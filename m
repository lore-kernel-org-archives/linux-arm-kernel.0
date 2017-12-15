From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 15 Dec 2017 10:44:17 +0200
Subject: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806 and
 CP110
In-Reply-To: <20171215093203.74b7a59c@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-2-miquel.raynal@free-electrons.com>
 <20171215082759.7t24ka3lpkulcb7r@tarshish>
 <20171215093203.74b7a59c@xps13>
Message-ID: <20171215084417.2vf77y4uvtixw252@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Miqu?l

On Fri, Dec 15, 2017 at 09:32:03AM +0100, Miquel RAYNAL wrote:
> On Fri, 15 Dec 2017 10:27:59 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> > 
> > On Thu, Dec 14, 2017 at 11:30:01AM +0100, Miquel Raynal wrote:
> > > +- marvell,thermal-zone-name: The name to identify the thermal zone
> > > +                             within the sysfs, useful when multiple
> > > +                             thermal zones are registered (AP,
> > > CPx...).  
> > 
> > I don't think that would be acceptable. DT is about describing the
> > hardware. sysfs is a Linux implementation detail which is not tied to
> > any specific hardware. If this is accepted, the property should be
> > named 'linux,thermal-zone-name'.
> 
> You are right the sysfs mention should not appear in the description.

My comment was not about the description language. I don't think that this 
property is acceptable at all. But I'll let DT maintainers comment on that.

> Otherwise for the naming I'm not sure "linux," is a valid prefix in
> that case.

We use the 'linux' prefix for input key names and led triggers, for example.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
