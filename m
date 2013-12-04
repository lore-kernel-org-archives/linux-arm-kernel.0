From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 4 Dec 2013 01:35:15 +0000
Subject: [PATCH v3 00/10] Add power management support for chipidea
In-Reply-To: <20131203181546.GA27706@kroah.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
 <20131203181546.GA27706@kroah.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A6498041427BA@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > Hi Greg,
> >
> > This serial adds power management (system & runtime) for chipidea core.
> > With this, the chipidea controller can be at low power mode when it is
> not in
> > use, and the chipidea controller can be the system wakeup source.
> > It needs to depend on my patch[1], since [1]-"Add power management
> support for MXS PHY"
> > adds some common PHY APIs, and this serial uses it.
> >
> > It has been verified at Freescale i.mx6Q/DL SabreSD, i.mx28 evk
> platform
> > (no runtime pm support), I will verify it at other FSL platforms during
> > the patch review.
> 
> This series doesn't apply to my tree anymore.
> 
> And there have been a ton of chipidea patches floating around, I've now
> dropped them all from my "todo" queue and will wait for you to collect
> them and forward them on as I'm totally lost with all of the different
> versions and objections and the like.
> 

Greg, I will do that.

Peter
