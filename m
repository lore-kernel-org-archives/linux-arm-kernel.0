From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 14:59:41 +0100
Subject: [PATCH 0/1 for 4.4-rc8] ARM: Fix broken USB support in
 sunxi_defconfig
In-Reply-To: <20160101132501.F192B6C803F0@dd34104.kasserver.com>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
 <4865776.yyMBHQfnua@wuerfel>
 <20160101132501.F192B6C803F0@dd34104.kasserver.com>
Message-ID: <4797602.u4tEtbBRPK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 January 2016 14:25:01 Timo Sigurdsson wrote:
> Hi Arnd,
> 
> Arnd Bergmann schrieb am 31.12.2015 16:46:
> 
> > On Tuesday 29 December 2015 02:47:32 Timo Sigurdsson wrote:
> >> Here is a late patch aimed for 4.4-rc8 (or 4.4). It would be nice if this   
> >> could make it into 4.4 in order to avoid unpleasent surprises (and
> >> subsequent questions) with builds based on sunxi_defconfig. At the moment,
> >> some boards (e.g. LeMaker BananaPi) are left with non-functional USB ports
> >> as a newly added driver is required to power them.
> > 
> > It's a bit confusing to send a patch to so many recipients, that usually
> > leads to nobody applying it. I can put it into the fixes branch in arm-soc
> > but need an Ack from the sunxi maintainer(s).
> 
> Sorry, I didn't know any better. Almost all recipients came from the
> get-maintainers script (which I thought were mandatory to include). What's
> the recommended way in such cases?

Just put everyone on Cc, and have the most appropriate recipient (which you
expect to act on the path) as 'To'. Also, address that person in the
cover letter so they know they should act on it, e.g. "Hi Maxime,
can you pick up this patch and forward it to arm-soc?".
 
> I already prepared and tested a patch for multi_v7_defconfig which I'll
> send to the same recipients as before just for the sake of not shutting
> out people that were previously addressed in this conversation.

Ok, thanks.

	Arnd
