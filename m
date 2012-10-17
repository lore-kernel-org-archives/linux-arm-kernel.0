From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 16 Oct 2012 17:39:00 -0700
Subject: [PATCHv4 8/8] ARM: OMAP3: do not delete per_clkdm autodeps during
 idle
In-Reply-To: <alpine.DEB.2.00.1210160603390.9767@utopia.booyaka.com> (Paul
 Walmsley's message of "Tue, 16 Oct 2012 07:29:21 +0000 (UTC)")
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-9-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1209182156330.4747@utopia.booyaka.com>
 <alpine.DEB.2.00.1209182241400.4747@utopia.booyaka.com>
 <87k3vpek28.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1210160603390.9767@utopia.booyaka.com>
Message-ID: <877gqqlyor.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> Here's an updated version of this one, with the erratum coverage expanded 
> to include OMAP34xx/35xx.
>
> I think this one can replace Tero's "[PATCHv6 06/11] ARM: OMAP: 
> clockdomain: add support for preventing autodep delete" and "[PATCHv6 
> 07/11] ARM: OMAP3: do not delete per_clkdm autodeps during idle".  Tero, 
> please let us know if you feel otherwise.
>
> The patch seems to pass testing on 37xx.  Was not able to really test it 
> on 35xx due to PM regressions in v3.7-rc1.

With workarounds for some of the other regressions, this passes ret/off
idle/suspend tests on 3530/Overo, 3730/OveroSTORM and 3730/Beagle-xM.  

Queueing for v3.7-rc.

Thanks,

Kevin
