From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Fri, 15 Dec 2017 09:32:03 +0100
Subject: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806
 and CP110
In-Reply-To: <20171215082759.7t24ka3lpkulcb7r@tarshish>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-2-miquel.raynal@free-electrons.com>
 <20171215082759.7t24ka3lpkulcb7r@tarshish>
Message-ID: <20171215093203.74b7a59c@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Fri, 15 Dec 2017 10:27:59 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Miquel
> 
> On Thu, Dec 14, 2017 at 11:30:01AM +0100, Miquel Raynal wrote:
> > +- marvell,thermal-zone-name: The name to identify the thermal zone
> > +                             within the sysfs, useful when multiple
> > +                             thermal zones are registered (AP,
> > CPx...).  
> 
> I don't think that would be acceptable. DT is about describing the
> hardware. sysfs is a Linux implementation detail which is not tied to
> any specific hardware. If this is accepted, the property should be
> named 'linux,thermal-zone-name'.

You are right the sysfs mention should not appear in the description.

Otherwise for the naming I'm not sure "linux," is a valid prefix in
that case.

Miqu?l
