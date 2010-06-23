From: PeterHuewe@gmx.de (Peter =?iso-8859-1?q?H=FCwe?=)
Date: Thu, 24 Jun 2010 01:28:41 +0200
Subject: [PATCH] arm/include: Fix missing semicolon in module.h
In-Reply-To: <20100617092419.GI17639@pcarmody-desktop>
References: <201006161932.00542.PeterHuewe@gmx.de>
	<20100617092419.GI17639@pcarmody-desktop>
Message-ID: <201006240128.41556.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag 17 Juni 2010 11:24:19 schrieb Phil Carmody:
> On 16/06/10 19:32 +0200, ext Peter Huewe wrote:
> > From: Peter Huewe <peterhuewe@gmx.de>
> >
> > This patch fixes a missing semicolon which introduced buildfailures [2]
> > for almost every arm defconfig, introduced by patch cecaa4c6b [1]
> >
> > This issue arises only if CONFIG_ARM_UNWIND is not set.
> >
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> 
> My bad, sorry.
> 
> Acked-by: Phil Carmody <ext-phil.2.carmody@nokia.com>


Any updates on this one ? 

Peter
