From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 8 Feb 2017 14:13:22 +0100 (CET)
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <20170122121506.9995-1-linus.walleij@linaro.org>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1702081401080.8463@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Sun, 22 Jan 2017, Linus Walleij wrote:

> I got a Gemini platform from Florian Fainelli over at OpenWRT
> some time back. I finally got around to "future-proofing" the
> platform, which was the idea when he paintakingly sent the box
> over to me.
> 

now I've got my toolchain cleaned up and working ...
Tested on may nas 4220
  
here my
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

> - FOT2G USB EHCI host

The fotg2 driver is already upstream.
I've added DT support and this driver works.
The only problem here is dis/reconnect of usb devices, but I think this 
is some driver problem here.

I must clean up my DT support patches to send them of.

Greetings
Hans Ulli Kroll
