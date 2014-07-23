From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jul 2014 19:15:35 -0400
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <10A7C530-7CD2-4ED0-889A-7FAC1922320F@perenite.com>
References: <1406154923-13612-1-git-send-email-yahoo@perenite.com>
 <1406154923-13612-2-git-send-email-yahoo@perenite.com>
 <20140723224236.GC28485@lunn.ch>
 <94F87063-D717-435B-B7C5-EDAC9B26742C@perenite.com>
 <20140723225841.GD28485@lunn.ch>
 <10A7C530-7CD2-4ED0-889A-7FAC1922320F@perenite.com>
Message-ID: <20140723231535.GK23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 01:11:12AM +0200, Benoit Masson wrote:
> Le 24 juil. 2014 ? 00:58, Andrew Lunn <andrew@lunn.ch> a ?crit :
> 
> >> For the marvell,mv78230-a0-i2c unfortunately i've spend 3 hours
> >> trying to understand this but it only works with this on the
> >> ix4-300d :(. There was multiple patch around this and maybe one
> >> broke the auto-detect part of this, I've tried compiling with some
> >> 3.10 or lower kernel but no luck here I still have to put this a0
> >> option.
> > 
> > Lets first confirm you have an a0 SoC.
> > 
> > At boot time, it should print:
> > 
> > pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);
> > 
> > What revision do you have?
> > 
> > If the auto detect code really is broken, Gregory will likely take a
> > look.
> 
> I sure do,
> 
> confirmed by u-boot  output below:
> 
> U-Boot 2009.08 (Mar 04 2013 - 11:13:04) Marvell version:  2.3.2 PQ
> U-Boot Addressing:
>        Code:..00600000:006BFFF0
>        BSS:..00708EC0
>        Stack:..0x5fff70
>        PageTable:.0x8e0000
>        Heap address:.0x900000:0xe00000
> Board: DB-78230-BP rev 2.0 Wistron
> SoC:   MV78230 A0
> 
> From kernel I get:
> 
> mvebu-soc-id: MVEBU SoC ID=0x7823, Rev=0x1

Well, isn't that a peach?  :)  Gregory?

thx,

Jason.
