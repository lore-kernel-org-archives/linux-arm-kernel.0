From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 May 2014 08:02:31 -0700
Subject: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
In-Reply-To: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20140521150231.GH17417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:51]:
> Hi,
> 
> Here are the AM43xx and OMAP5 display DT changes again. I've sent the clock
> related changes separately, and I removed OMAP5's RFBI node, which depends on
> more clock changes. The RFBI driver doesn't work at the moment anyway, so
> removing the RFBI node should not be an issue.
> 
> Tony, if these look fine (the rfbi change is the only one compared to the
> previous versions), can you queue them for 3.16?

Probably best that you do a late branch again after arm-soc dts changes
have been merged. Sounds like you have at least that macro dependency
to omap-for-v3.16/dt-v2 so you should probably base your branch on
that. So for this:

Acked-by: Tony Lindgren <tony@atomide.com>
