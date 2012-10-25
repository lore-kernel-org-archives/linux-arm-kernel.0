From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 19:09:50 +0000 (UTC)
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
In-Reply-To: <20121025185755.GV11928@atomide.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
 <20121025185755.GV11928@atomide.com>
Message-ID: <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Tony Lindgren wrote:

> Ideally we'd have some Linux generic function to implement in the PRM/CM
> drivers for getting the bootreason. But I guess we don't?

Do you know of one, apart from WDIOC_GETBOOTSTATUS?


- Paul
