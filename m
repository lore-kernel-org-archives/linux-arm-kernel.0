From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 09:57:14 +0800
Subject: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
In-Reply-To: <20160330210916.GB21993@roeck-us.net>
References: <20151106220249.GA19791@roeck-us.net>
 <565F4244.7090502@timesys.com>
 <CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
 <CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
 <20151228162923.GA31680@spo001.leaseweb.nl>
 <56AA79DA.2010305@timesys.com>
 <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
 <56F991C3.8030201@timesys.com> <20160330012226.GD28207@tiger>
 <20160330210916.GB21993@roeck-us.net>
Message-ID: <20160331015714.GM28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 02:09:16PM -0700, Guenter Roeck wrote:
> The question was if the property name should be ext-reset-output or
> fsl,ext-reset-output. In my opinion, it should be fsl,ext-reset-output
> because it is not a generic property. Tim disagrees.
> 
> So we have two options: Change the property name to fsl,ext-reset-output,
> which I would accept, or wait for a devicetree maintainer to make a decision.

Guenter,

I agree with you on this point.  Before everyone agrees that this is a
generic binding, we should have vendor prefix for the property.

Tim,

This is a small change which, IMO, shouldn't hold an useful patch from being
merged.  Care to resend with the suggested change?

Shawn
