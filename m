From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 18:43:56 +0200
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140519155732.GA4849@atomide.com>
References: <53730AFB.2090800@ti.com> <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com>
Message-ID: <4508837.NI0TQZBQLi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 May 2014 08:57:33 Tony Lindgren wrote:
> No need to load multiple drivers at this point. That's why I'm saying
> you can bail out on the undesired display controller probes using
> of_machine_is_compatible test. It's not that uncommon for drivers to do:
> 
> $ git grep of_machine_is_compatible drivers/ | wc -l
> 116

I think this is widely seen as bad style, and most of the examples are
testing for Power Mac specific workarounds for stuff that Apple didn't
put in DT elsewhere.

	Arnd
