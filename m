From: plyatov@gmail.com (Igor Plyatov)
Date: Wed, 20 Apr 2011 15:43:23 +0400
Subject: [PATCH] mach-at91: gsia18s board improvements and bug fixes
In-Reply-To: <20110420105120.GI4204@game.jcrosoft.org>
References: <1303291399-4075-1-git-send-email-plyatov@gmail.com>
	<20110420105120.GI4204@game.jcrosoft.org>
Message-ID: <4DAEC6DB.8000600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Christophe!
> On 13:23 Wed 20 Apr     , Igor Plyatov wrote:
>> * AT91_PIN_Pxxx port names replaced by human readable GPO_xxxx, GPI_xxxx,
> I do not see the improvement

This does not mean that here is no it for all!
This is very noticeable improvement for me regarding to schematic and 
source code maintenance.

>>    GPIO_xxxx names. This simplify source code and schematic maintenance.
>> * Active logic levels and default states corrected for GPOs.
>> * Replace small functions which use platform_register_device() by its direct
>>    calls.
> ditto here

Source code is and more clean and simple now.

>> * Remove GPIO_CARD_UNMOUNT_1 gpio_keys_button, because it not used.
>> * debounce_interval added for critical buttons.
>> * Remove unneeded GPI setup code for buttons, because this done by corresponding
>>    driver.
>> * pcf8574x_0x20_setup() and pcf8574x_0x20_teardown functions small refactoring.
> Best Regards,
> J.
