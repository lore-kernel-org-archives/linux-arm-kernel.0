From: marex@denx.de (Marek Vasut)
Date: Sat, 24 May 2014 13:26:26 +0200
Subject: [PATCH 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <201405231246.10365.arnd@arndb.de>
References: <1400771396-9686-1-git-send-email-clabbe.montjoie@gmail.com>
 <537E3E2F.7000407@gmail.com> <201405231246.10365.arnd@arndb.de>
Message-ID: <201405241326.26260.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 23, 2014 at 12:46:10 PM, Arnd Bergmann wrote:
> On Thursday 22 May 2014, Corentin LABBE wrote:
> > Le 22/05/2014 17:28, Arnd Bergmann a ?crit :
> > > On Thursday 22 May 2014 17:09:56 LABBE Corentin wrote:
> > >> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > 
> > > My feeling is that this should either be one driver that provides
> > > all five algorithms unconditionally, or five drivers that are each
> > > separate loadable modules and based on top of a common module
> > > that only exports functions but has no active logic itself
> > 
> > I agree for the split.
> > It was my first intention but I feared to add too many files.
> > So I propose to split in 6, sunxi-ss-hash.c, sunxi-ss-des.c,
> > sunxi-ss-aes.c, sunxi-ss-rng.c, sunxi-ss-common.c and sunxi-ss.h Does
> > can I add a sunxi-ss directory in drivers/crypto ?
> 
> Yes, I think a subdirectory would be best.

Full ACK on this one. Use drivers/crypto/sunxi-ss/ .
[...]

Best regards,
Marek Vasut
