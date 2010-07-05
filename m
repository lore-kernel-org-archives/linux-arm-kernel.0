From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jul 2010 11:33:48 +0300
Subject: [PATCH 17/33] Removing dead SX1_OLD_FLASH
In-Reply-To: <201006302024.47025.marek.vasut@gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<5b21086199b139a61888c16e92d3efe6b205dae2.1277911346.git.siccegge@cs.fau.de>
	<201006302024.47025.marek.vasut@gmail.com>
Message-ID: <20100705083346.GI15951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Vasut <marek.vasut@gmail.com> [100630 21:21]:
> Dne St 30. ?ervna 2010 17:59:25 Christoph Egger napsal(a):
> > SX1_OLD_FLASH doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> 
> There were two models of the phone made, you can toggle between old and new 
> version. Maybe better documentation won't hurt.

Sounds like this should be done dynamically based on omap_rev,
or some cmdline option from the bootloader? Not applying this
one.

Tony
