From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 6 Oct 2009 09:19:10 -0600 (MDT)
Subject: [PATCH 2/8] omap: Lock DPLL5 at boot
In-Reply-To: <20091002223859.11962.20369.stgit@localhost>
References: <20091002223510.11962.21751.stgit@localhost>
	<20091002223859.11962.20369.stgit@localhost>
Message-ID: <alpine.DEB.2.00.0910060918560.7395@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Oct 2009, Tony Lindgren wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Lock DPLL5 at 120MHz at boot. The USBHOST 120MHz f-clock and
> USBTLL f-clock are the only users of this DPLL, and 120MHz is
> is the only recommended rate for these clocks.
> 
> With this patch, the 60 MHz ULPI clock is generated correctly.
> 
> Tested on an OMAP3430 SDP.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Signed-off-by: Paul Walmsley <paul@pwsan.com>


- Paul
