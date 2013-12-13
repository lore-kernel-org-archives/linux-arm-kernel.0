From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 13 Dec 2013 07:09:54 -0700
Subject: [PATCH V1 07/11] ARM: dts: imx6qdl-sabrelite: add pwms for
 backlights
In-Reply-To: <201312131253.32773.marex@denx.de>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-8-git-send-email-troy.kisky@boundarydevices.com>
 <201312131253.32773.marex@denx.de>
Message-ID: <52AB1532.7070203@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 12/13/2013 04:53 AM, Marek Vasut wrote:
> On Friday, December 13, 2013 at 02:49:11 AM, Troy Kisky wrote:
>> add pwm1 for lcd backlight
>> add pwm4 for lvds backlight
>> add pwm3 for ov5640 mipi clock
>
> The camera needs a PWM ? I am a little surprised by such a design, but I might
> just be lacking knowledge.
>

The PWM is used to provide a clock to the camera (with a constant
50% duty cycle).

We do the same with our parallel camera interface, avoiding
external oscillators.

Regards,


Eric
