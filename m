From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Jun 2013 11:29:48 +0200
Subject: getting allwinner SoC support upstream (was Re: Uploading linux
 (3.9.4-1))
In-Reply-To: <CAKON4OyyRF4Z46RyJFDWUwo4L52Z8bgSH0CzDr2gDerw4iDwcw@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OyyRF4Z46RyJFDWUwo4L52Z8bgSH0CzDr2gDerw4iDwcw@mail.gmail.com>
Message-ID: <20130606112948.7cd444a4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 5 Jun 2013 16:48:27 -0400, jonsmirl at gmail.com wrote:

> >  fex covers *eeeeeevvveeerryyyythiiiing* - right from flipping the
> > multiplexing for all 3 SD/MMC cards so that you can pretend that SD0
> > is SD2 and you can specify *different* GPIOs for each to say which
> > is
> 
> You can do all of this in device tree too. If the exact syntax doesn't
> exist you can use 'allwinner,' prefixes on the node names.
> Also check out pinctrl so that it doesn't get reinvented.

Are people looking at the mainline source code?

There is already a pinctrl driver for sunxi platforms (i.e Allwinner
SoCs), it's at drivers/pinctrl/pinctrl-sunxi.c, and it's DT-based and
allows to describe the pin muxing in the Device Tree.

Cc'ing Maxime Ripard, who is the mach-sunxi maintainer in the mainline
kernel.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
