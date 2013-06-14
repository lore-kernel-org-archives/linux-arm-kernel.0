From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 14 Jun 2013 02:57:46 +0000 (UTC)
Subject: OMAP v3.10-rc regressions that no one's fixed
In-Reply-To: <20130612174842.GQ8164@atomide.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
 <20130612174842.GQ8164@atomide.com>
Message-ID: <alpine.DEB.2.02.1306140257270.5514@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130610 00:27]:
>
> > * 37xx EVM: boot fails
> >   - as of v3.10-rc1
> >   - Cause unknown
> 
> This one is probably because of broken GPIO numbering in
> the board file that uses hardcoded GPIOs for what are probably
> twl GPIOs.
> 
> Does commenting out omap3_evm_display_init() in the board file
> fix the booting for you?

Lokesh's patch fixes it here.


- Paul
