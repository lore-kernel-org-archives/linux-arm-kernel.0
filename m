From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Sep 2013 02:58:15 +0000 (UTC)
Subject: OMAP baseline test results for v3.12-rc3
In-Reply-To: <alpine.DEB.2.02.1309300158430.17980@utopia.booyaka.com>
References: <alpine.DEB.2.02.1309300158430.17980@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1309300257070.17980@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


One of the changes to this testbed, starting with the v3.12-rc kernels, is 
the addition of an OMAP4460-based Variscite VAR-SOM-OM DVK board, 
graciously donated by Jeff Graham at Bruker Optics.

Right now, the bootloader and userspaces in use are the ones that came 
with the board.  So it should be representative of the mainline kernel's 
ability to boot to userspace on many similar board designs.


- Paul
