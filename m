From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu, 14 Jun 2018 10:17:20 +0000
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
In-Reply-To: <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
 <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
Message-ID: <a20cc6a0c278cc2791c0bdfc30a79b022de396ef.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-07 at 14:07 -0300, Fabio Estevam wrote:
> Hi Leonard,
> 
> On Thu, Jun 7, 2018 at 2:00 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> 
> > +
> > +                       isl29023 at 44 {
> 
> According to Devicetree Specification v0.2 document:
> 
> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming model."
> 
> So you could write:
> 
> light-sensor at 44

Ok, will fix in v2.

Should I also assign a label, like "isl29023: light-sensor at 44"? I
couldn't find any recommendation on this.

There are no immediate uses for a label but this practice is very
common. Having labels allows creating minor board variants with reduced
churn in the base dts so it seems good.

--
Regards,
Leonard
