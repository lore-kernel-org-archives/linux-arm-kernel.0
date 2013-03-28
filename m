From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 09:48:22 +0800
Subject: [PATCH v2 5/5] ARM: imx: Remove cpufreq driver
In-Reply-To: <20130327151454.GC6347@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
 <1364389294-1997-6-git-send-email-mpa@pengutronix.de>
 <20130327140529.GG2674@S2101-09.ap.freescale.net>
 <20130327151454.GC6347@pengutronix.de>
Message-ID: <20130328014820.GC5429@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 04:14:54PM +0100, Markus Pargmann wrote:
> I just prepared a patch for mx51 babbage board. cpuimx51sd does not seem
> to have a DTS file yet. In general I think the operating points have to
> be in the board specific DTS files because the frequencies of imx51
> devices are different.

Shouldn't the operating-points generally be SoC specific?  I think we
should have the operating-points recommended by SoC design added in
<soc>.dtsi, and if there is an odd system design requiring different
settings, we can override the operating-points in <board>.dts.

Shawn
