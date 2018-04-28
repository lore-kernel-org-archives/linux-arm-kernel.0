From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Sat, 28 Apr 2018 12:50:31 +0200
Subject: [PATCH 13/17] dt-bindings/interrupt-controller: update Marvell
 ICU bindings
In-Reply-To: <20180428124204.3f305405@xps13>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-14-miquel.raynal@bootlin.com>
 <20180427204723.hz2ef5f7fhaid3aj@rob-hp-laptop>
 <20180428124204.3f305405@xps13>
Message-ID: <20180428125031.6f46c448@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 28 Apr 2018 12:42:04 +0200, Miquel Raynal wrote:

> On Fri, 27 Apr 2018 15:47:23 -0500, Rob Herring <robh@kernel.org> wrote:
> 
> > On Sat, Apr 21, 2018 at 03:55:33PM +0200, Miquel Raynal wrote:  
> > > Change the documentation to reflect the new bindings used for Marvell
> > > ICU. This involves describing each interrupt group as a subnode of the
> > > ICU node. Each of them having their own compatible.    
> > 
> > Why?
> > 
> > This breaks compatibility.  
> 
> It does indeed.

Well, yes and no: your driver supports both the old and new binding, so
the compatibility is not broken. So, yes the binding is changed in an
incompatible way, but the driver continues to support the old binding.

Perhaps the binding documentation should continue to document the
legacy binding, mark it as still supported but deprecated.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
