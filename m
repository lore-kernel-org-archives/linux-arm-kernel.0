From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 16:36:22 +0100
Subject: [PATCH v9] Regulator: Add Anatop regulator driver
In-Reply-To: <20120307134551.GL3107@opensource.wolfsonmicro.com>
References: <1331126658-26926-1-git-send-email-paul.liu@linaro.org>
 <20120307132225.GB17745@game.jcrosoft.org>
 <20120307134551.GL3107@opensource.wolfsonmicro.com>
Message-ID: <20120307153622.GC17745@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:45 Wed 07 Mar     , Mark Brown wrote:
> On Wed, Mar 07, 2012 at 02:22:25PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > > +- compatible: Must be "fsl,anatop-regulator"
> > > +- vol-bit-shift: Bit shift for the register
> > > +- vol-bit-width: Number of bits used in the register
> > > +- min-bit-val: Minimum value of this register
> > > +- min-voltage: Minimum voltage of this regulator
> > > +- max-voltage: Maximum voltage of this regulator
> 
> > specific properites need to be prefix by the vendor
> 
> This really doesn't seem at all sane for a device which is already
> vendor specific, it's just noise in the bindings.
No it's
Here is a good example as we have regulator generic binding & vendor
specific bindig

Best Regards,
J.
