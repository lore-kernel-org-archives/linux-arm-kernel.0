From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 15:45:50 +0800
Subject: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
In-Reply-To: <20120925073808.GZ1322@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
Message-ID: <20120925074548.GJ27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 09:38:08AM +0200, Sascha Hauer wrote:
> So you want to make the code conform to the common spec which has
> bus-width as a required property. Is this really worth it to add an
> incompatible change to our devicetrees?
> 
I do want to have our implementation conform to common spec.  At the
current stage devicetrees are not stable anyway, so we should make
them right as much as possible before they start getting maintained
separately from kernel tree, where we will be asked to maintain
devicetree compatibility a lot harder.

Shawn
