From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 11:44:21 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515091838.GC6820@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch>
Message-ID: <20120515114421.7fce8be6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 11:18:38 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> Is mach-armada a good idea? What are many different armada chipsets
> families:
> 
> Armada 100, 300, 500, 600, 1000, 15000, XP. 
> 
> You only seem to support 300 and XP. Where would the others go? 300 is
> actually mach-dove, etc. 

We support 370 and XP in this new mach directory, and we've chosen to
support them in an unique directory in order to easily validate the fact
that we are able to build and run a single binary kernel image that
works on both SoCs.

We are definitely open to suggestions regarding the naming of the
directory, or even combining with existing Marvell SoCs support if it
makes sense. What would be your suggestion on this?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
