From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 15 Dec 2011 22:10:05 -0700 (MST)
Subject: [PATCHv12 0/9] OMAP3+: PRCM chain handler
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Message-ID: <alpine.DEB.2.00.1112152207440.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

This series was boot-tested on a 4430 ES2 Panda also.  It generates the 
following message on boot:

PRCM: failed to allocate irq descs: -12

which is an -ENOMEM coming from irq_alloc_descs().  This is probably 
because OMAP hasn't been converted to use sparse IRQs yet.

Until that happens, this message should be harmless.


- Paul
