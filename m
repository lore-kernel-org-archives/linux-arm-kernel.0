From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 11:08:00 -0400 (EDT)
Subject: [PATCH 06/19] ARM: mach-at91: remove arch specific special
	handling for ioremap
In-Reply-To: <20110919130703.GG16141@game.jcrosoft.org>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-7-git-send-email-nico@fluxnic.net>
	<20110919130703.GG16141@game.jcrosoft.org>
Message-ID: <alpine.LFD.2.00.1109191106420.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:

> On 03:07 Fri 16 Sep     , Nicolas Pitre wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > A generic version should replace this later.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Untill the replace will availlable
> 
> do not remove it

The replacement is introduced later in the same patch series.  Removing 
this first doesn't cause any functional regression.


Nicolas
