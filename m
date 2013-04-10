From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Apr 2013 14:57:57 -0400
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
In-Reply-To: <20130410205102.0c7d3b53@skate>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130410130902.GA29100@localhost> <20130410192106.73d81f2c@skate>
 <20130410183024.GB2275@localhost> <20130410205102.0c7d3b53@skate>
Message-ID: <20130410185757.GF28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas (both),

On Wed, Apr 10, 2013 at 08:51:02PM +0200, Thomas Petazzoni wrote:
> On Wed, 10 Apr 2013 15:30:25 -0300, Ezequiel Garcia wrote:
> 
> > Indeed it applies cleanly on v3.9-rc6, thank you. On my AXP and A370
> > boards:
> > 
> > Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> Thanks for your testing!
> 
> Thomas (tglx), are you ok with the drivers/irqchip/ changes?


Would it be alright if we took this series through arm-soc with your
Ack?  Unfortunately, I see no way to reorder it or split it up to
prevent cross tree dependencies.  Conflicts on your side should be
trivial.

thx,

Jason.
