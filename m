From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 19:40:47 -0700
Subject: [RFC PATCH 05/10] documentation/dt: Add mpu, dsp and iva bindings
In-Reply-To: <4E695E20.5070506@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-6-git-send-email-b-cousson@ti.com>
	<20110908180910.GE2967@ponder.secretlab.ca>
	<4E695E20.5070506@ti.com>
Message-ID: <20110909024047.GA6726@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 02:30:24AM +0200, Cousson, Benoit wrote:
> On 9/8/2011 8:09 PM, Grant Likely wrote:
> >>+- compatible : Should be:
> >>+  - "ti,ivahd", "ti,iva" for OMAP4
> >>+  - "ti,iva2", "ti,iva" for OMAP3
> >>+  - "ti,iva1", "ti,iva" for OMAP2
> >
> >Again, be specific to the instantiation and encode the omap version
> >into the compatible value.  Use the form "ti,omap4-*", etc.
> 
> In that case, I do not necessarily agree. The IVA is a generic TI IP
> used in various chips. The IP version is well documented in the TRM.
> 
> OK, in fact I didn't pick the proper version:-(
> It should be:
> 
> +  - "ti,ivahd", for OMAP4
> +  - "ti,iva2.2", for OMAP3
> +  - "ti,iva2.1", for OMAP2430
> +  - "ti,iva1", for OMAP2420
> 
> But still, no need to rely on OMAP version to identify the IVA version.

Fair enough, providing that the "ti,iva" value is dropped.

g.
