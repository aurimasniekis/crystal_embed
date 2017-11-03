abstract class STM32::Base::GPIO
    enum Level
        LOW
        HIGH
    end

    PIN_0                          = 0x0001u16
    PIN_1                          = 0x0002u16
    PIN_2                          = 0x0004u16
    PIN_3                          = 0x0008u16
    PIN_4                          = 0x0010u16
    PIN_5                          = 0x0020u16
    PIN_6                          = 0x0040u16
    PIN_7                          = 0x0080u16
    PIN_8                          = 0x0100u16
    PIN_9                          = 0x0200u16
    PIN_10                         = 0x0400u16
    PIN_11                         = 0x0800u16
    PIN_12                         = 0x1000u16
    PIN_13                         = 0x2000u16
    PIN_14                         = 0x4000u16
    PIN_15                         = 0x8000u16
    PIN_ALL                        = 0xFFFFu16
    
    PIN_MASK                       = 0x0000FFFFu32

    PIN_RESET                      = 0
    PIN_SET                        = 1

    MODE_INPUT                     = 0x00000000u32 # Input Floating Mode                   
    MODE_OUTPUT_PP                 = 0x00000001u32 # Output Push Pull Mode                 
    MODE_OUTPUT_OD                 = 0x00000011u32 # Output Open Drain Mode                
    MODE_AF_PP                     = 0x00000002u32 # Alternate Function Push Pull Mode     
    MODE_AF_OD                     = 0x00000012u32 # Alternate Function Open Drain Mode    
    
    MODE_ANALOG                    = 0x00000003u32 # Analog Mode  
    
    MODE_IT_RISING                 = 0x10110000u32 # External Interrupt Mode with Rising edge trigger detection          
    MODE_IT_FALLING                = 0x10210000u32 # External Interrupt Mode with Falling edge trigger detection         
    MODE_IT_RISING_FALLING         = 0x10310000u32 # External Interrupt Mode with Rising/Falling edge trigger detection  
    
    MODE_EVT_RISING                = 0x10120000u32 # External Event Mode with Rising edge trigger detection               
    MODE_EVT_FALLING               = 0x10220000u32 # External Event Mode with Falling edge trigger detection              
    MODE_EVT_RISING_FALLING        = 0x10320000u32 # External Event Mode with Rising/Falling edge trigger detection


    SPEED_FREQ_LOW                 = 0x00000000u32 # range up to 0.4 MHz, please refer to the product datasheet
    SPEED_FREQ_MEDIUM              = 0x00000001u32 # range 0.4 MHz to 2 MHz, please refer to the product datasheet
    SPEED_FREQ_HIGH                = 0x00000002u32 # range   2 MHz to 10 MHz, please refer to the product datasheet
    SPEED_FREQ_VERY_HIGH           = 0x00000003u32 # range  10 MHz to 35 MHz, please refer to the product datasheet

    NOPULL                         = 0x00000000u32 #  No Pull-up or Pull-down activation 
    PULLUP                         = 0x00000001u32 #  Pull-up activation 
    PULLDOWN                       = 0x00000002u32 #  Pull-down activation 


    property pin : UInt32?
    property mode : UInt32?
    property pull : UInt32?
    property speed : UInt32?
    property alternative : UInt32?

  
    def self.init(): Nil

    end


    def self.de_init(): Nil

    end

    def self.read_pin(pin : UInt16): Level

    end

    def self.write_pin(pin : UInt16, state : Level): Nil

    end

    def self.toggle_pin(pin : UInt16): Nil

    end

    def self.lock_pin(pin : UInt16)

    end

    def self.exti_irq_handler(pin : UInt16): Nil
    end

    def self.exti_callback(pin : UInt16): Nil
    end


    macro exti_get_flag(exti_line)
        STM32::Registers::EXTI.pr & exti_line
    end

    macro exti_clear_flag(exti_line)
        STM32::Registers::EXTI.pr = exti_line
    end

    macro exti_get_it(exti_line)
        STM32::Registers::EXTI.pr & exti_line
    end

    macro exti_clear_it(exti_line)
        STM32::Registers::EXTI.pr - exti_line
    end

    macro exti_generate_swit(exti_line)
        STM32::Registers::EXTI.swier |= exti_line
    end

    {% if !flag?(:release) %}

    macro is_pin_action(action)
        (
            (action == PIN_RESET) ||
            (action == PIN_SET)
        )
    end

    macro is_pin(pin)
        ((pin & PIN_MASK) != 0x00u32) && ((pin & ~PIN_MASK) == 0x00u32)
    end

    macro is_mode(mode)
        (
            (mode == MODE_INPUT) ||
            (mode == MODE_OUTPUT_PP) ||
            (mode == MODE_OUTPUT_OD) ||
            (mode == MODE_AF_PP) ||
            (mode == MODE_AF_OD) ||
            (mode == MODE_IT_RISING) ||
            (mode == MODE_IT_FALLING) ||
            (mode == MODE_IT_RISING_FALLING) ||
            (mode == MODE_EVT_RISING) ||
            (mode == MODE_EVT_FALLING) ||
            (mode == MODE_EVT_RISING_FALLING) ||
            (mode == MODE_ANALOG)
        )
    end

    macro is_speed(speed)
        (
            (speed == SPEED_FREQ_LOW) ||
            (speed == SPEED_FREQ_MEDIUM) ||
            (speed == SPEED_FREQ_HIGH) ||
            (speed == SPEED_FREQ_VERY_HIGH)
        )
    end

    macro is_pull(pull)
        (
            (pull == NOPULL) ||
            (pull == PULLDOWN) ||
            (pull == PULLUP)
        )
    end


    {% end %}
end