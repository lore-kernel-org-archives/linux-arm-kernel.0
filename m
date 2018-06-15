From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2018 17:16:31 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
In-Reply-To: <a20cc6a0c278cc2791c0bdfc30a79b022de396ef.camel@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
 <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
 <a20cc6a0c278cc2791c0bdfc30a79b022de396ef.camel@nxp.com>
Message-ID: <CAOMZO5D0fBcwD+6SHor+mGvB=7m8WrTmi-QPTYWjMnQchVATOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 7:17 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> Should I also assign a label, like "isl29023: light-sensor at 44"? I
> couldn't find any recommendation on this.
>
> There are no immediate uses for a label but this practice is very
> common. Having labels allows creating minor board variants with reduced
> churn in the base dts so it seems good.

In the case of this specific board we don't have board variants, so no
need to add a label.
