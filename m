From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 07 Dec 2011 10:45:25 +0200
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <20111205154611.GV11150@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111203112206.GE6043@opensource.wolfsonmicro.com> <4EDCCAE0.2000009@ti.com>
 <20111205154611.GV11150@opensource.wolfsonmicro.com>
Message-ID: <4EDF27A5.7090909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2011 05:46 PM, Mark Brown wrote:
> And what I'm saying is that my main concern is that you're publishing
> documenting a binding which isn't intended to be the the final binding
> and which there's no intention that anyone should use directly anyway.

I felt it is the right thing to document the current situation.
The documentation will be updated as we can move away from the
"ti,hwmods" tag from DT.
I can place comment in the documentation for omap-dmic, omap-mcpdm
stating that the use of "ti,hwmods" is required at the moment, but it is
temporally solution.

-- 
P?ter
