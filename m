From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 09:58:27 +0800
Subject: [PATCH] i.MX6: Documentation: update from fsl,card-wired to
 non-removable
In-Reply-To: <1368687094-11385-1-git-send-email-dirk.behme@de.bosch.com>
References: <1368687094-11385-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20130517015825.GC3893@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 08:51:34AM +0200, Dirk Behme wrote:
> With the commit 7f217794f (mmc: dt: Consolidate DT bindings),
> the device tree properties used by various device drivers
> for SD/MMC host controllers were standardized.  One of the changes
> was that the property "fsl,card-wired", previously used by the
> Freescale driver, was replaced with "non-removable". Fix the example
> documentation regarding this.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied, thanks.
