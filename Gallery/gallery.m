//
//  gallery.c
//  Gallery
//
//  Created by David Wagner on 21/03/2019.
//  Copyright © 2019 David Wagner. All rights reserved.
//

#include "gallery.h"

#include <mach-o/dyld.h>
#include <dlfcn.h>

static void note_image_added(const struct mach_header* mh, intptr_t vmaddr_slide) {
    struct dl_info info = { 0 };
    dladdr(mh, &info);
    
    printf("Loaded: %s\n\tNearest symbol: %s\n", info.dli_fname, info.dli_sname);
}

static void note_image_removed(const struct mach_header* mh, intptr_t vmaddr_slide) {
    struct dl_info info = { 0 };
    dladdr(mh, &info);
    
    printf("Removed: %s\n\tNearest symbol: %s\n", info.dli_fname, info.dli_sname);
}

void install_handlers(void) {
    _dyld_register_func_for_add_image(note_image_added);
    _dyld_register_func_for_remove_image(note_image_removed);
}

NSArray<NSString *> * image_name_list(void) {
    uint32_t image_count = _dyld_image_count();
    NSMutableArray<NSString *> *images = [NSMutableArray array];
    for (uint32_t i = 0; i < image_count; i++) {
        const char *image_name =_dyld_get_image_name(i);
        [images addObject:[NSString stringWithCString:image_name encoding:NSUTF8StringEncoding]];
    }
    return [images copy];
}
