From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 17:03:25 +0100
Subject: [PATCH 0/1 for 4.4-rc8] ARM: Fix broken USB support in
 sunxi_defconfig
In-Reply-To: <20151231160049.GA23528@lukather>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
 <4865776.yyMBHQfnua@wuerfel> <20151231160049.GA23528@lukather>
Message-ID: <6543489.noPmtJKUnO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 December 2015 17:00:49 Maxime Ripard wrote:
> Hi Arnd,
> 
> On Thu, Dec 31, 2015 at 04:46:01PM +0100, Arnd Bergmann wrote:
> > On Tuesday 29 December 2015 02:47:32 Timo Sigurdsson wrote:
> > > Here is a late patch aimed for 4.4-rc8 (or 4.4). It would be nice if this   
> > > could make it into 4.4 in order to avoid unpleasent surprises (and
> > > subsequent questions) with builds based on sunxi_defconfig. At the moment,
> > > some boards (e.g. LeMaker BananaPi) are left with non-functional USB ports
> > > as a newly added driver is required to power them.
> > 
> > It's a bit confusing to send a patch to so many recipients, that usually
> > leads to nobody applying it. I can put it into the fixes branch in arm-soc
> > but need an Ack from the sunxi maintainer(s).
> 
> You have mine
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

> Timo, don't we need the same thing for multi_v7?

Good point.

Timo, please create a patch for that one as well and test it, I can
also apply that on the fixes branch.

	Arnd
