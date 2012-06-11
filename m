From: b32955@freescale.com (Huang Shijie)
Date: Mon, 11 Jun 2012 13:56:33 +0800
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <20120611054500.GB2552@S2101-09.ap.freescale.net>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <20120606081726.GG2667@S2101-09.ap.freescale.net>
 <201206082103.09612.marex@denx.de>
 <20120611054500.GB2552@S2101-09.ap.freescale.net>
Message-ID: <4FD58891.7050609@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?06?11? 13:45, Shawn Guo ??:
> On Fri, Jun 08, 2012 at 09:03:09PM +0200, Marek Vasut wrote:
>>> I just applied Huang's gpmi changes below.  Can you please rebase the
>>> the patch on top of it?  If you have the same pin setup as imx28-evk,
>>> we can save above data completely.
>>>
>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/169351
>> Well, GPMI NAND doens't work for me (AGAIN). Screw this, I'm not debuging it for
>> the third damn time only to be told to rebase it again and that all I did was
>> for naught. Sorry
>>
> Hmm, I was told by Huang that GPMI NAND works for him.  As I do not
sorry. It can not works now. :(

There is a bug in the GPMI-NAND driver( i guess).

The pinmux, clocks, IO resources are all correct.
And the ECC read page/ ECC write page are ok too.

But the UBIFS can not works.

I am debugging it now.

Huang Shijie





> have NAND device to play, can you guys aligned here?
>
