From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 08:39:11 +0000
Subject: [PATCH v2] ARM: Orion: Fix WDT compile for Dove and MV78xx0
In-Reply-To: <alpine.LFD.2.02.1206291205240.31003@xanadu.home>
References: <1340954759-32085-1-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1206291205240.31003@xanadu.home>
Message-ID: <201207040839.12481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 June 2012, Nicolas Pitre wrote:
> On Fri, 29 Jun 2012, Andrew Lunn wrote:
> 
> > Commit 0fa1f0609a0c1fe8b2be3c0089a2cb48f7fda521 (ARM: Orion: Fix
> > Virtual/Physical mixup with watchdog) broke the Dove & MV78xx0
> > build. Although these two SoC don't use the watchdog, the shared
> > platform code still needs to build. Add the necessary defines.
> > 
> > Cc: stable at vger.kernel.org
> > Reported-by: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Tested-by: Nicolas Pitre <nico@linaro.org>
> 

Applied to fixes branch for 3.5.

Thanks,

	Arnd
