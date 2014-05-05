From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 5 May 2014 18:05:20 +0200
Subject: [PATCH v2 0/5] ARM: mvebu: fixes and improvements for 375 support
In-Reply-To: <20140505153654.GO28159@titan.lakedaemon.net>
References: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140505153654.GO28159@titan.lakedaemon.net>
Message-ID: <20140505180520.7af699de@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 5 May 2014 11:36:54 -0400, Jason Cooper wrote:

> > Thomas Petazzoni (5):
> >   ARM: mvebu: fix thermal quirk SoC revision check
> >   ARM: mvebu: initialize mvebu-soc-id earlier
> >   ARM: mvebu: add Armada 375 A0 revision definition
> >   ARM: mvebu: conditionalize Armada 375 SMP workaround
> >   ARM: mvebu: conditionalize Armada 375 coherency workaround
> 
> hmmm, I didn't get #5...

Weird because it made it through the LAKML:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253251.html

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
