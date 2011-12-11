From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 11 Dec 2011 11:20:47 +0800
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <4EDF27A5.7090909@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111203112206.GE6043@opensource.wolfsonmicro.com>
 <4EDCCAE0.2000009@ti.com>
 <20111205154611.GV11150@opensource.wolfsonmicro.com>
 <4EDF27A5.7090909@ti.com>
Message-ID: <20111211032046.GH2800@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 10:45:25AM +0200, Peter Ujfalusi wrote:

> I felt it is the right thing to document the current situation.

If we're going to document bindings like this it feels like we should
have a split in the directories in the same way that we handle the
different stability levels for sysfs documentation.

> The documentation will be updated as we can move away from the
> "ti,hwmods" tag from DT.
> I can place comment in the documentation for omap-dmic, omap-mcpdm
> stating that the use of "ti,hwmods" is required at the moment, but it is
> temporally solution.

At the very least, yes.
