From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 18 Jul 2012 03:54:49 -0600 (MDT)
Subject: [PATCHv6 2/7] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX GIC control register change.
In-Reply-To: <1342605105.4672.95.camel@sokoban>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-3-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1207180314250.28834@utopia.booyaka.com>
 <1342605105.4672.95.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1207180354200.16772@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jul 2012, Tero Kristo wrote:

> There isn't public erratum number for this, thats the reason for xxx. I
> can change the xxx to GICD though if that is better.

Yep please do (or something else more meaningful than GICD if you can 
think of something better).


- Paul
