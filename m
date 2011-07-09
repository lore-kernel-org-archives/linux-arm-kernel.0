From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 9 Jul 2011 02:26:18 -0600 (MDT)
Subject: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
In-Reply-To: <1309599388.1846.12.camel@deskari>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-18-git-send-email-b-cousson@ti.com>
	<1309598037.1846.3.camel@deskari>
	<1309599388.1846.12.camel@deskari>
Message-ID: <alpine.DEB.2.00.1107090224410.15984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2 Jul 2011, Tomi Valkeinen wrote:

> Even after removing the "fck"s from the hwmod data, I see:
> 
> [    0.218200] omap_device: omapdss_dss: fck already exist
> [    0.218231] omap_device: omapdss_dss: sys_clk already exist
> [    0.218231] omap_device: omapdss_dss: tv_clk already exist
> [    0.218292] omap_device: omapdss_dss: video_clk already exist
> 
> I think those come from the clock44xxx_data.c. I believe those are more
> or less exact duplicates from the driver's point of view? If so, I guess
> the ones in clockdata could be removed after adding those to hwmod data?

I've removed these too.


thanks,

- Paul
