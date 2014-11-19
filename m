From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Nov 2014 11:07:14 +0100
Subject: [PATCH 1/3] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <CAD=FV=Xkei_wxa3jWb8bPvuynbSyq4o=ezjVD0+e04aOPCAM+Q@mail.gmail.com>
References: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>	<1416246184-29071-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=Xkei_wxa3jWb8bPvuynbSyq4o=ezjVD0+e04aOPCAM+Q@mail.gmail.com>
Message-ID: <546C6BD2.4020802@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

Thanks for your feedback.

On 11/18/2014 06:50 PM, Doug Anderson wrote:
> This is common practice in the Chrome OS tree, but we've gotten
> pushback from upstream questioning about whether "spidev" is really a
> physical device.  See:
> 
> http://www.spinics.net/lists/linux-samsung-soc/msg29563.html
> 

I see, I thought that it was a common practice in the mainline kernel
too since I saw that many board DTS currently have a spidev node:

$ git grep 'compatible = "spidev"' arch/arm/boot/dts/ | wc -l
19

> 
> I don't really have an answer for something better to do here but I
> figured I'd at least bring up the point.
> 

I wonder how the spidev user-space interface is supposed to be used
when booting with Device Trees.

Best regards,
Javier
