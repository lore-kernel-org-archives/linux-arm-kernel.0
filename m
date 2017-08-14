From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Aug 2017 09:22:20 -0700
Subject: [PATCH 3/3] mfd: twl: move header file out of I2C realm
In-Reply-To: <20170814084340.65morabelapfegph@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
 <20170814084340.65morabelapfegph@ninjato>
Message-ID: <20170814162219.GX8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wolfram Sang <wsa@the-dreams.de> [170814 01:43]:
> 
> > > Given the triviality of the change for non-MFD subsystems, can we apply
> > > this for 4.14?
> > 
> > I can't apply anything without Acks for *all* of the subsystems above.
> 
> Well, there are cases when you can. Those should be exceptions and well
> justified, of course.
> 
> > My suggestion would be to collect the Acks you've received up until
> > this point and identify which SS's are still lacking in change log
> > section of a RESEND.
> 
> I agree, though, that I can try a second round to get the acks.

As long as it's been compile tested with omap2plus_defconfig:

Acked-by: Tony Lindgren <tony@atomide.com>
