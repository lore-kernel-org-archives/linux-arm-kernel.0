From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Feb 2012 10:43:53 -0800
Subject: [PATCH v3 2/3] MFD: twl6040: Convert to i2c driver, and
 separate it from twl core
In-Reply-To: <1328868018-24668-3-git-send-email-peter.ujfalusi@ti.com>
References: <1328868018-24668-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868018-24668-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120221184353.GP18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120210 01:29]:
> Complete the separation of the twl6040 from the twl core since
> it is a separate chip, not part of the twl6030 PMIC.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>

This should be OK to merge via the ASoC tree:

Acked-by: Tony Lindgren <tony@atomide.com>
