From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 19:15:37 +0800
Subject: [PATCH 3/3] net: fec: add phy-reset-interval for device tree probe
In-Reply-To: <20457.31943.332545.171232@ipc1.ka-ro>
References: <1340700308-8315-1-git-send-email-shawn.guo@linaro.org>
 <1340700308-8315-4-git-send-email-shawn.guo@linaro.org>
 <20457.31943.332545.171232@ipc1.ka-ro>
Message-ID: <20120626111535.GB8858@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:11:35AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > Different boards may require different phy reset interval time.  Add
> > property phy-reset-interval for device tree probe, so that the boards
> > that need a longer interval time can specify it in their device tree.
> >
> 'phy-reset-duration' would be a more appropriate name.
> 
Ok, point taken.  Thanks.

-- 
Regards,
Shawn
