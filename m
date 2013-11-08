From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 07 Nov 2013 16:06:29 -0800 (PST)
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <3394178.9T7q17vczr@avalon>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87zjpggalc.wl%kuninori.morimoto.gx@renesas.com>
 <871u2s65kz.wl%kuninori.morimoto.gx@renesas.com>
 <3394178.9T7q17vczr@avalon>
Message-ID: <87li0zrc3m.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent

> Sure, if the hardware is very similar, it makes sense to share code. I've had 
> a quick look at the M2 documentation, and it seems to be indeed mostly 
> identical to H2. Only a couple of clocks are missing, and a new GPU clock 
> register is documented. As the GPU clock is mentioned in the H2 documentation 
> as being programmable I would assume that the GPU clock register exists and is 
> identical in H2 but has been forgotten in the documentation.
> 
> We should probably extend clock-r8a7790.c with M2 support and rename it to 
> clock-rcar-gen2.c before pushing it to mainline. Would you like to submit a 
> patch ? :-)

Thank yor for your agreement.
I don't want to send "rename patch",
please consider it in your v2 patch if possible :P

Best regards
---
Kuninori Morimoto
