From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 14:50:13 -0700
Subject: [PATCH v2 4/9] regulator: lp873x: Add support for populating
 input supply
In-Reply-To: <20161109182618.ajqhtffure76zfnf@rob-hp-laptop>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <20161021103841.8044-5-lokeshvutla@ti.com>
 <20161030204118.ojeetnxl5qsi6lp7@rob-hp-laptop>
 <e5619d78-5752-c8fb-8a11-6629c4b7c3f6@ti.com>
 <20161109182618.ajqhtffure76zfnf@rob-hp-laptop>
Message-ID: <20161109215013.GF2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [161109 11:26]:
> On Wed, Nov 02, 2016 at 10:58:40AM +0530, Lokesh Vutla wrote:
> > On Monday 31 October 2016 02:11 AM, Rob Herring wrote:
> > > On Fri, Oct 21, 2016 at 04:08:36PM +0530, Lokesh Vutla wrote:
> > >> In order to have a proper topology of regulators for a platform, each
> > >> registering regulator needs to populate supply_name field for identifying
> > >> its supply's name. Add supply_name field for lp873x regulators.
> > >>
> > >> Cc: Lee Jones <lee.jones@linaro.org>
> > >> Cc: Keerthy <j-keerthy@ti.com>
> > >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > >> ---
> > >>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
> > >>  drivers/regulator/lp873x-regulator.c             | 1 +
...

> Acked-by: Rob Herring <robh@kernel.org>

Please send this patch separately to the regulator maintainer.

Thanks,

Tony
