From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 15:39:27 +0100
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <50227936.3040701@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
 <20120808125252.GR16861@opensource.wolfsonmicro.com>
 <50227936.3040701@ti.com>
Message-ID: <20120808143927.GB24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 05:35:34PM +0300, Peter Ujfalusi wrote:

> Does this needs the common clock framework on the platform? OMAP3 certainly
> does not have it enabled since it has not been adopted.

I'd hope at least the binding code for finding clocks has been done at
the clkdev level so it can be used on other platforms but perhaps that's
not the case.
