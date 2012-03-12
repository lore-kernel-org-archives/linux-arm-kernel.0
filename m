From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 12 Mar 2012 04:13:16 -0600 (MDT)
Subject: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
In-Reply-To: <1331546427.2116.264.camel@sokoban>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
 <1331546427.2116.264.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1203120412230.11332@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero, Rajendra,

On Mon, 12 Mar 2012, Tero Kristo wrote:

> Just tested your branch with omap3 beagle + omap4 blaze (with my omap4
> cswr set on top), and it works on both.
> 
> For the WUCLK poll bit I added detailed comments on patch 2 thread, but
> my current understanding is that the implementation now on omap3 / omap4
> is what they should be due to IP differences (except maybe the small
> optimization for omap3 part you commented about.)

Thank you both for the detailed comments and explanation on this series, 
and the testing... sounds like this set is okay to go.


- Paul
