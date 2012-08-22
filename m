From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 22 Aug 2012 13:11:23 +0000
Subject: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp header into
 platform and audio specific
In-Reply-To: <20120817223358.GI18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
 <20120817223358.GI18871@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA67D44@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 18, 2012 at 04:03:58, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:01PM +0530, Hebbar, Gururaja wrote:
> > Davinci McASP header & driver are shared by few OMAP platforms (like
> > TI81xx, AM335x). Splitting asp header into Davinci platform specific
> > header and Audio specific header helps to share them across platforms.
> 
> This doesn't apply against v3.6-rc2, I suspect there's overlapping
> changes in arch/arm.  I was just going to apply it on a separate branch
> to allow cross-tree merge if there's overlap with architecture work.
> Can you please check and resend?

I will re-apply and send it as v2

> 


Regards, 
Gururaja
