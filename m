From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 13 Jun 2012 17:55:47 -0600 (MDT)
Subject: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for 3.5-rc
In-Reply-To: <1339162255.2091.56.camel@sokoban>
References: <20120607060901.25532.68354.stgit@dusk>
 <1339162255.2091.56.camel@sokoban>
Message-ID: <alpine.DEB.2.00.1206131755130.30212@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Fri, 8 Jun 2012, Tero Kristo wrote:

> Tested this set on top of v3.5-rc1 with omap3 / omap4 suspend + my omap4
> core retention / dev-off patches. There are a couple of minor issues,
> like the bug in patch 5, and the fact that counter_32k hwmod data is
> broken for omap4. This fix is needed on omap4 to fix the counter_32k, if
> this is not done, device off does not work:

Thanks for the testing and the reminder.  Will send the next version of 
this soon to address more comments from Tony.


- Paul
