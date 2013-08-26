From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 26 Aug 2013 20:49:53 +0530
Subject: [PATCH 1/3] dma: imx-sdma: Use struct for driver data
In-Reply-To: <1376985873-25776-2-git-send-email-s.hauer@pengutronix.de>
References: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
 <1376985873-25776-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130826151953.GS2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 10:04:31AM +0200, Sascha Hauer wrote:
> Use a struct type instead of an enum type for distinguishing between
> different versions. This makes it simpler to handle multiple differences
> withtou cluttering the code with comparisons for certain devtypes.
typo^^^^^, fixed it up while applying

~Vinod
