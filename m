From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 10 Nov 2014 20:00:05 +0000
Subject: [PATCH v2 2/2] arm64: Add Juno SoC device tree.
In-Reply-To: <54610C86.9090002@suse.de>
References: <1415618875-8469-1-git-send-email-Liviu.Dudau@arm.com>
 <1415618875-8469-3-git-send-email-Liviu.Dudau@arm.com>
 <54610C86.9090002@suse.de>
Message-ID: <20141110200005.GA10247@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 07:05:42PM +0000, Andreas F?rber wrote:
> Hi,
> 
> Am 10.11.2014 um 12:27 schrieb Liviu Dudau:
> > diff --git a/arch/arm64/boot/dts/juno.dts b/arch/arm64/boot/dts/juno.dts
> > new file mode 100644
> > index 0000000..7f998de
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/juno.dts
> > @@ -0,0 +1,374 @@
> > +/*
> > + * ARM Ltd. Juno Plaform
> 
> "Platform"
> 
> > + *
> 
> Shouldn't this mention a license, ideally dual-licensed?

Hi Andreas,

TBH I wasn't sure a license was needed. Most (all?) of ARM's DT
files don't seem to carry a license, but I will add the appropriate
license. And yes, it is dual-licensed (GPLv2 or BSD)

> 
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	model = "Juno";
> > +	compatible = "arm,juno", "arm,vexpress";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &soc_uart0;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		A53_0:cpu at 100 {
> [snip]
> 
> Can you please add a space after colon, like you did for non-CPU nodes?

Sure, will do.

Best regards,
Liviu

> 
> Regards,
> Andreas
> 
> -- 
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
