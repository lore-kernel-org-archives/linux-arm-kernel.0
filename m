From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Dec 2013 12:53:32 +0100
Subject: [PATCH V1 07/11] ARM: dts: imx6qdl-sabrelite: add pwms for
 backlights
In-Reply-To: <1386899355-17379-8-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-8-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <201312131253.32773.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 13, 2013 at 02:49:11 AM, Troy Kisky wrote:
> add pwm1 for lcd backlight
> add pwm4 for lvds backlight
> add pwm3 for ov5640 mipi clock

The camera needs a PWM ? I am a little surprised by such a design, but I might 
just be lacking knowledge.

Best regards,
Marek Vasut
