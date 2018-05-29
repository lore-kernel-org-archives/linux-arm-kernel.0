From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 29 May 2018 08:08:44 +0000
Subject: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
In-Reply-To: <CAMuHMdWPFOjT9qk0Z4+-nSTumjhN_Q6Ntwh3__CgBCobquX8Rg@mail.gmail.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
 <8736yb5jez.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdWPFOjT9qk0Z4+-nSTumjhN_Q6Ntwh3__CgBCobquX8Rg@mail.gmail.com>
Message-ID: <871sdu6g6b.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> > HDMI sound doesn't use hdmi0_con.
> > You can do it now, thanks
> 
> Thanks, so hdmi0_con can be moved now.
> 
> But HDMI sound does use hdmi0/ports/port at 2. right?

Yes

Best regards
---
Kuninori Morimoto
