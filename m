From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 22:58:32 +0100
Subject: [PATCH v4 5/5] ARM: multi_v7_defconfig: Enable LP872x regulator
 support
In-Reply-To: <20160229215446.GP13417@atomide.com>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-6-git-send-email-contact@paulk.fr>
 <20160229215446.GP13417@atomide.com>
Message-ID: <3559918.7gA8u2p4Bl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 13:54:46 Tony Lindgren wrote:
> * Paul Kocialkowski <contact@paulk.fr> [160228 04:40]:
> > The LP872x regulator is used in the LG Optimus Black codename sniper to supply
> > the external mmc card.
> 
> This patch needs to be sent directly to arm at kernel.org to avoid
> merge conflicts. I've picked the omap2plus_defconfig related change
> into omap-for-v4.6/defconfig.

I'd actually prefer it as part of the omap-for-v4.6/defconfig branch.
Taking care of merge conflicts is easy.

	Arnd
