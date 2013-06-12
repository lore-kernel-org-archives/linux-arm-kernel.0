From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 06:54:54 -0700
Subject: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
In-Reply-To: <51B6D502.5010208@iki.fi>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com>
 <20130607175005.GB3331@atomide.com> <51B5ACA6.2010101@iki.fi>
 <20130610141451.GE8164@atomide.com> <51B6D502.5010208@iki.fi>
Message-ID: <20130612135454.GS8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@iki.fi> [130611 00:49]:
> On 10/06/13 17:14, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@iki.fi> [130610 03:44]:
> 
> >> DSS does not have DT bindings, and removing DSS from hwmod data will
> >> break DSS for omap4.
> > 
> > Ah that's right. Care to post a patch reverting the minimal parts that
> > you need for omap4 against omap-for-v3.11/cleanup?
> 
> This one adds back the DSS data.

OK thanks, applying into omap-for-v3.11/cleanup.

Regards,

Tony
