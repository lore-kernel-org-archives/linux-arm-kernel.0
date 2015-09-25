From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Sep 2015 17:33:13 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56056836.4060307@free.fr>
References: <56001B78.2090001@free.fr> <2210529.vnGEGUl8Dr@wuerfel>
 <56054DA8.4050903@free.fr> <7559792.th4E1kM5gi@wuerfel>
 <56056836.4060307@free.fr>
Message-ID: <56056939.5090409@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/2015 17:28, Mason wrote:

> About NEON. I had 'select VFP' but I see that CPU_V7 enables VFPv3 and VFP.
> Isn't NEON required to support user-space programs using NEON instructions?
> arch/arm/kernel/entry-armv.S

I'm taking cues from exynos and omap2, are these good references?

config ARCH_OMAP2PLUS_TYPICAL (default y) selects NEON if CPU_V7.
Can I do something similar? (My platform is only CPU_V7.)

Regards.
