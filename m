From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 03:10:57 -0600 (MDT)
Subject: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
In-Reply-To: <4FF1977B.1080002@ti.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
 <alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com>
 <4FF1977B.1080002@ti.com>
Message-ID: <alpine.DEB.2.00.1207040307530.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Jul 2012, Benoit Cousson wrote:

> Unfortunately the clock fmwk cannot handle module as a clock node.

Hmm.  We have to have similar support in the clockfw for the CLKDIV32K 
clock for AM33xx.  That uses the modulemode bits to enable and disable the 
clock.  Or does this require something more complicated?


- Paul
