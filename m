From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 17:01:25 -0500
Subject: [RFC PATCH 1/6] Documentation: arm: ti: Add bindings for AM654 SoC
In-Reply-To: <20180612210519.GA17653@rob-hp-laptop>
References: <20180605060125.9518-1-nm@ti.com> <20180605060125.9518-2-nm@ti.com>
 <20180612210519.GA17653@rob-hp-laptop>
Message-ID: <20180612220125.3scgr6by62wifirp@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:05-20180612, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:01:20AM -0500, Nishanth Menon wrote:
[...]
> > +Boards based on K3 Multicore SoC architecture shall have the following property:
> > +- compatible: Every hardware block introduced in K3 Multicore SoC
> > +  architecture shall be of the form:
> > +  "ti,XXX-YYY", where:
> > +     'XXX' represents the specific SoC part for which the support is added.
> > +     'YYY' represents the corresponding peripheral in SoC being supported.
> 
> No need to explain standard DT convention here. (But I don't think we 
> have this convention documented anywhere, so patches welcome. :))
> 

Thanks. Will drop off from my series (will skip the generic dts
convention for now ;) ).
-- 
Regards,
Nishanth Menon
