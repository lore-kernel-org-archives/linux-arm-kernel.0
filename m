From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 21 Oct 2010 22:08:01 -0400 (EDT)
Subject: [PATCH 2/2] [ARM] Kirkwood: add fan support for Network Space Max
	v2
In-Reply-To: <1287712396.9690.378.camel@groeck-laptop>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287330612-11256-2-git-send-email-simon@sequanux.org>
	<1287712396.9690.378.camel@groeck-laptop>
Message-ID: <alpine.LFD.2.00.1010212202400.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Oct 2010, Guenter Roeck wrote:

> On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> > 
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> I assume this will get pushed through the ARM tree, right ?

Might be simpler if this is routed along the same path as the core code 
it relies upon to avoid dependency ordering issues.  There is nothing 
particularly ARM specific here anyway.


Nicolas
