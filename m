From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Thu, 30 Aug 2018 21:20:18 +0200
Subject: [PATCH] leds: add TI LMU backlight driver
In-Reply-To: <20180830082219.GA10133@amd>
References: <20180829212032.GB15786@amd> <20180830082219.GA10133@amd>
Message-ID: <c72eb0ff-b54c-4670-580c-e31625b3c275@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Thank you for the patch.

Looking for DT bindings I can find the following

Documentation/devicetree/bindings/mfd/ti-lmu.txt,

which for LED bindings redirects to:

"[2] ../leds/leds-lm3633.txt",

but it is not present in the mainline.

Best regards,
Jacek Anaszewski

On 08/30/2018 10:22 AM, Pavel Machek wrote:
> 
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> 
> It controls LEDs on Droid 4
> smartphone, including keyboard and screen backlights.
> 
> Signed-off-by: Milo Kim <milo.kim@ti.com>
> [add LED subsystem support for keyboard backlight and rework DT
> binding according to Rob Herrings feedback]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [remove backlight subsystem support for now]
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
[...]
