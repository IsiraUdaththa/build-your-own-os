#ifndef __MOUSE_H__
#define __MOUSE_H__

#include <arch/x86/interrupts.h>
#include <arch/x86/port.h>
#include <common/types.h>

class MouseDriver : public InterruptHandler {
    Port8Bit dataport;
    Port8Bit commandport;
    uint8_t buffer[3];
    uint8_t offset;
    uint8_t buttons;

    int8_t x, y;

   public:
    MouseDriver(InterruptManager* manager);
    ~MouseDriver();
    virtual uint32_t HandleInterrupt(uint32_t esp);
};

#endif  // __MOUSE_H__
