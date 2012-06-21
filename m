From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Jun 2012 23:43:16 -0600 (MDT)
Subject: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <4FE2B2C6.4010904@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-5-git-send-email-rnayak@ti.com>
 <20120614191147.GP19410@gmail.com> <4FDAC07A.7020702@ti.com>
 <20120620114149.GG12766@atomide.com> <4FE2B2C6.4010904@ti.com>
Message-ID: <alpine.DEB.2.00.1206202342360.10198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jun 2012, Rajendra Nayak wrote:

> Paul, are you ok to look at them as preparatory patches for CCF
> conversion too?

Yes.  Also it looks like some of these patches should go through Mike 
since they add features to the CCF, so it's probably best to break those 
out into a separate series too.

- Paul
