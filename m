From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Aug 2010 12:36:22 +0300
Subject: [PATCH 2/3] OMAP3630: Add ES1.1 and ES1.2 detection
In-Reply-To: <4C59B92C.5060300@ti.com>
References: <20100804112916.25027.94640.stgit@baageli.muru.com>
	<20100804113307.25027.8630.stgit@baageli.muru.com>
	<4C59B92C.5060300@ti.com>
Message-ID: <20100805093621.GW9881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [100804 21:55]:
> Tony Lindgren had written, on 08/04/2010 06:33 AM, the following:
> >From: Anand Gadiyar <gadiyar@ti.com>
> >+		default:
> >+			omap_revision =  OMAP3630_REV_ES1_2;
> >+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
> >+			break;
> >+		}
> 
> we need to add a break here. to jump out of the main switch statement.
> currently with ES1.0 3630, it reports as 3630 ES1.2

Argh.. It's merged already, care to do another patch
to fix this?
 
> Tested and verified on SDP3630 with OMAP3630 ES1.0

OK, thanks.

Tony
