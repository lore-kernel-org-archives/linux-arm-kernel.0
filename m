From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Dec 2011 15:46:11 +0000
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <4EDCCAE0.2000009@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111203112206.GE6043@opensource.wolfsonmicro.com>
 <4EDCCAE0.2000009@ti.com>
Message-ID: <20111205154611.GV11150@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 03:45:04PM +0200, Peter Ujfalusi wrote:
> On 12/03/2011 01:22 PM, Mark Brown wrote:

> > Actually thinking about this some more I think what's concerning me is
> > the documentation as much as anything else - if it was just an internal,
> > unpublished interface of the OMAP core code which happened to use device
> > tree I probably wouldn't have worried about it churning.

> Actually it is documented here:
> Documentation/devicetree/bindings/arm/omap/omap.txt

That's not exactly the point...

> In order to move all OMAP drivers to DT - as Benoit already mentioned -
> we need additional work in DT.
> At this point of time if we add the DT representation we anyways need to
> change it as the core will receive the features, and we still need to
> fall back to hwmod to get the drivers working.
> As soon as we can migrate away from the hwmod we will do, but having
> this in place helps us to migrate other parts to DT.

And what I'm saying is that my main concern is that you're publishing
documenting a binding which isn't intended to be the the final binding
and which there's no intention that anyone should use directly anyway.
