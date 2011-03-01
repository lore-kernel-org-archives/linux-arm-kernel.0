From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Feb 2011 17:17:38 -0700 (MST)
Subject: [PATCH 2/4] OMAP2/3: clockdomains: remove warnings on an
	OMAP3-only compile
In-Reply-To: <20110226002006.28142.52520.stgit@twilight.localdomain>
References: <20110226001601.28142.46636.stgit@twilight.localdomain>
	<20110226002006.28142.52520.stgit@twilight.localdomain>
Message-ID: <alpine.DEB.2.00.1102281716460.29478@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Feb 2011, Paul Walmsley wrote:

> Resolve these compile-time gcc warnings on OMAP3-only kernel compiles:
> 
> .../mach-omap2/clockdomains2xxx_3xxx_data.c:95: warning: 'dsp_24xx_wkdeps' defined but not used
> .../mach-omap2/clockdomains2xxx_3xxx_data.c:119: warning: 'mpu_24xx_wkdeps' defined but not used
> .../mach-omap2/clockdomains2xxx_3xxx_data.c:147: warning: 'core_24xx_wkdeps' defined but not used
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

For the archives, I've dropped this patch and replaced it with Sanjeev's 
patch here:

    http://marc.info/?l=linux-omap&m=129893821929982&w=2


- Paul
