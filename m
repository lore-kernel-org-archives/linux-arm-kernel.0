From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 22 Jun 2012 12:58:21 -0600 (MDT)
Subject: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-9-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-9-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the omap crypto clocks.

These drivers should be converted to use runtime PM instead, since that 
needs to be done anyway.


- Paul
