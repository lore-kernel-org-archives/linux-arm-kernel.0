From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 03 Apr 2013 20:26:39 -0700 (PDT)
Subject: APE6EVM and Runtime PM
In-Reply-To: <20130404020019.GA7163@verge.net.au>
References: <20130404020019.GA7163@verge.net.au>
Message-ID: <87wqsjdlhv.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> in the course of looking look at consolidating our defconfigs I
> noticed that SMSC ethernet and rcar_thermal seem seem to not work when
> runtime PM is enabled.
> 
> I'm wondering if you have any ideas of what might be the cause of this
> or if you could give me some guidance on investigating this problem.
> 
> I assume that it relates to a clock or clocks not being enabled.

About rcar_thermal, it needs my patch which was sent to PM ML.
I got email from Zhang that he accepted my patch (pm_runtime support for thermal).
But it seems he didn't push his branch yet...
I guess I explained this on my [PATCH 0/x] email.

Best regards
---
Kuninori Morimoto
