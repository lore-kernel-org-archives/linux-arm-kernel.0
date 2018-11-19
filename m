From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Nov 2018 20:03:08 +0800
Subject: [PATCH] ARM: dts: imx6sx: specify proper clock for nodes with
 dummy clock
In-Reply-To: <1541580363-3968-1-git-send-email-Anson.Huang@nxp.com>
References: <1541580363-3968-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20181119120306.GR5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 08:51:07AM +0000, Anson Huang wrote:
> From i.MX6SX reference manual CCM chapter, KPP and
> WDOGn use IPG clock as their clock, specify IPG
> clock for KPP and WDOGn instead of DUMMY clock.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
