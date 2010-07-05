From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jul 2010 11:44:50 +0300
Subject: [PATCH 18/33] Removing dead OMAP_ARM_96MHZ
In-Reply-To: <201006302025.14881.marek.vasut@gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<8304abb0dbda307c488b6fe2b3cc8df3c9909eb6.1277911346.git.siccegge@cs.fau.de>
	<201006302025.14881.marek.vasut@gmail.com>
Message-ID: <20100705084448.GJ15951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Vasut <marek.vasut@gmail.com> [100630 21:21]:
> Dne St 30. ?ervna 2010 17:59:45 Christoph Egger napsal(a):
> > OMAP_ARM_96MHZ doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> 
> I'd be for adding it to Kconfig rather than removing from here

Looks like Paul has queued a patch to do this.

Tony
