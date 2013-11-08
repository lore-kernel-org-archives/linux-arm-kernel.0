From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 07 Nov 2013 22:02:23 -0800 (PST)
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <2305074.dSYTpfKiqG@avalon>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <3394178.9T7q17vczr@avalon>
 <87li0zrc3m.wl%kuninori.morimoto.gx@renesas.com>
 <2305074.dSYTpfKiqG@avalon>
Message-ID: <87k3gjqvmb.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent

> > Thank yor for your agreement.
> > I don't want to send "rename patch",
> > please consider it in your v2 patch if possible :P
> 
> We also need to take into account that the two SoCs will have a different 
> number of clocks. I'm thus inclined to replace the index-based switch 
> statement by a similar construct that will match on the clock name instead. Do 
> you have any opinion on that ?

Of course sharing code is very nice, but, 
sometimes, it makes code difficult/dirty.

Now, I understand your headache (I have same headache :),
and, you and I are sharing same opinion I think.
So, I believe your decision.

Best regards
---
Kuninori Morimoto
