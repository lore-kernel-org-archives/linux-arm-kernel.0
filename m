From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 12 Jun 2012 09:16:08 +0800
Subject: [GIT PULL] imx fixes for v3.5-rc (part 2)
In-Reply-To: <CAOesGMgJsSWh3QCNTDarGR7PPmO3_NMsueDun8o=igkt9a0_AA@mail.gmail.com>
References: <20120611044359.GD2344@S2101-09.ap.freescale.net>
 <CAAQ0ZWQ1D38onzk0aMaCTEQ-NSyCgEEUNwK3PfWbE2VUSG2ckQ@mail.gmail.com>
 <CAOesGMgJsSWh3QCNTDarGR7PPmO3_NMsueDun8o=igkt9a0_AA@mail.gmail.com>
Message-ID: <20120612011606.GJ2552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 09:44:41AM -0700, Olof Johansson wrote:
> > Shawn Guo (2):
> > ? ? ?ARM: imx6q: remove unneeded clkdev lookups
> 
> This is looking more like a cleanup, if it is, please hold off until
> 3.6. If it isn't please explain in the commit message what bug it
> fixes.
> 
Yes, it is a cleanup.  It cleans up some left-over from commit b0286f2
(ARM: imx6q: prepare and enable init on clks directly instead of
clk_get first) which is currently sitting on arm-soc/fixes.  I
originally sent the patch to Sascha and somehow expect him amend the
patch to that commit.  Anyway, it does not really matter, and we can
have it held off until 3.6.

-- 
Regards,
Shawn
