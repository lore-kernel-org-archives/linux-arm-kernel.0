From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Jul 2014 04:10:20 -0700
Subject: [PATCH 7/8] ARM: OMAP2+: timer: Add fallback for of_clk_get
In-Reply-To: <1398216429-4681-8-git-send-email-joelf@ti.com>
References: <1398216429-4681-1-git-send-email-joelf@ti.com>
 <1398216429-4681-8-git-send-email-joelf@ti.com>
Message-ID: <20140721111019.GZ18374@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [140422 18:27]:
> Not all platforms currently will support of_clk_get on timer
> because they may not have clock property in their DT nodes. Add
> code to handle this case so that things are kept working. Finally
> we can delete this code once all system timer nodes have a clock
> property.

I think this needs updating now too? Might be best to fix the
platforms that don't have clocks available yet via DT instead :)

Regards,

Tony
