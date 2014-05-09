From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 9 May 2014 18:09:02 +0200
Subject: [PATCH] ARM: dts: am335x-evm: fix comments for lcd pins
In-Reply-To: <20140509155929.GJ2626@ti.com>
References: <1399648580-14487-1-git-send-email-wsa@the-dreams.de>
 <20140509155929.GJ2626@ti.com>
Message-ID: <20140509160902.GA14250@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The same mistake is also in my EVMSK LCD enabling patch that is floating
> around on this list at the moment.  I will fix that and resend it.
> BeagleBone Black only uses the first 16 LCD pins so the dts for that is
> correct.

Well, even in the TI-based-3.2-kernel I originally got with the custom
hardware, this mistake was present in mach-omap2/mux33xx.c. No wonder it
spread from there :)

> Thanks for finding and fixing it.

Very welcome!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/38e01059/attachment.sig>
