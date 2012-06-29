From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jun 2012 05:44:27 -0700
Subject: [PATCH-V3 3/3] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
In-Reply-To: <4FEC7B33.5030500@ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
 <1340895567-22766-4-git-send-email-hvaibhav@ti.com>
 <4FEC72C2.7010106@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5D620@DBDE01.ent.ti.com>
 <4FEC7B33.5030500@ti.com>
Message-ID: <20120629124427.GE4202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [120628 08:46]:
> On 06/28/2012 05:39 PM, Hiremath, Vaibhav wrote:
> >On Thu, Jun 28, 2012 at 20:35:38, Cousson, Benoit wrote:
> >>
> >>OMAP4 does not have the SDRC but the EMIF like TI8XX.
> >>
> >
> >Benoit,
> >
> >This selection is happening for SOC_OMAP2420 and not for OMAP4.
> 
> Hehe, indeed, I missed the context and was fooled by the config ARCH_OMAP4.
> 
> I don't have any comment then :-)

That's very close to Acked-by then?

Tony
