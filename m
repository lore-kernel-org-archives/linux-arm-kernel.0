From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 29 Nov 2014 00:54:39 +0200
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411282349.00487@pali>
References: <20141027200008.GR2560@atomide.com> <201411282241.12095@pali>
 <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
 <201411282349.00487@pali>
Message-ID: <20141128225439.GC1382@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 11:49:00PM +0100, Pali Roh?r wrote:
> On Friday 28 November 2014 23:41:35 Aaro Koskinen wrote:
> > On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh?r wrote:
> > > uboot (in mode when is loaded from NOLO) has those issues:
> > > 
> > > 1) uboot cannot read n900 onenand mtd (uboot onenand driver
> > > not working, do not know why)
> > > 2) missing support for battery charging (can totally
> > > discharge battery)
> > 
> > NOLO enables watchdogs when booting. So if you get stuck in
> > the U-boot for whatever reason the device will power off
> > after ~30 secs or so.
> 
> Not truth!
> 
> Uboot RX51 code periodically kick watchdogs if are enabled. I 
> implemented that before RX51 uboot was merged into mainline.

Maybe then it shouldn't do that.

A.
