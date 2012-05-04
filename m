From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 10:31:24 -0700
Subject: [PATCH v2] arm: omap: fix trivial warnings for dspbridge
In-Reply-To: <1335191549-1047-1-git-send-email-felipe.contreras@gmail.com>
References: <1335191549-1047-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20120504173124.GF5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [120423 07:36]:
> arch/arm/plat-omap/devices.c: In function 'omap_dsp_reserve_sdram_memblock':
> arch/arm/plat-omap/devices.c:170: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
> arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_init':
> arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
> arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'phys_addr_t'

Thanks I'll apply this into fixes-non-critical.

Tony
