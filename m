From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 3 Mar 2016 15:38:28 +0000 (UTC)
Subject: [PATCH 10/11] ARM: DRA7: hwmod: Add data for
 McASP1/2/4/5/6/7/8
In-Reply-To: <56D81C49.6030706@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
 <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com>
 <56D5C6B1.6040005@ti.com>
 <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
 <56D81C49.6030706@ti.com>
Message-ID: <alpine.DEB.2.02.1603031532130.32459@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter,

On Thu, 3 Mar 2016, Peter Ujfalusi wrote:

> On 03/01/2016 07:01 PM, Paul Walmsley wrote:
> >>> 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should be 
> >>> "dra7xx_mcasp1__l3_main_1"-style links to indicate this.
> >>
> >> I need to check this, but I don't think McASP1,2,3 can be bus-master onto L3.
> > 
> > OK.  When you get back, maybe doublecheck this - it looks to me from 
> > SPRUHZ6 that McASP1-3 have built-in DMA controllers.
> 
> They are only targets on L3. Not sure about the built-in DMA controller

OK thanks.  I took a closer look at SPRUHZ6E and I think I was mistaken 
about those blocks having DMA controllers.  So you can ignore this part
of my comments :-)

- Paul
