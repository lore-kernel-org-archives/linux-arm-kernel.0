From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 9 Jul 2011 02:24:38 -0600 (MDT)
Subject: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
In-Reply-To: <1309598037.1846.3.camel@deskari>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-18-git-send-email-b-cousson@ti.com>
	<1309598037.1846.3.camel@deskari>
Message-ID: <alpine.DEB.2.00.1107090224100.15984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 2 Jul 2011, Tomi Valkeinen wrote:

> This patch adds "fck" opt-clocks for DSS. After your patch set
> for_3.1/5_auto_fck_clkdev, in which you create "fck" automatically, I
> see:
> 
> [    0.218231] omap_device: omapdss_dss: fck already exist
> [    0.218261] omap_device: omapdss_dss: fck already exist
> [    0.218261] omap_device: omapdss_dss: sys_clk already exist
> [    0.218261] omap_device: omapdss_dss: tv_clk already exist
> [    0.218322] omap_device: omapdss_dss: video_clk already exist
> [    0.218627] omap_device: omapdss_dispc: fck already exist
> [    0.219329] omap_device: omapdss_venc: fck already exist
> [    0.219635] omap_device: omapdss_dsi1: fck already exist
> [    0.219970] omap_device: omapdss_dsi2: fck already exist
> [    0.220336] omap_device: omapdss_hdmi: fck already exist
> 
> So I think the "fck" clocks in this patch should be removed. I only
> added them for compatibility, as I didn't have the automatic "fck"
> creation patch in my tree.

Thanks Tomi, I've gone ahead and removed these.


- Paul
