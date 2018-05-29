From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 29 May 2018 01:44:04 +0000
Subject: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
In-Reply-To: <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
Message-ID: <8736yb5jez.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> > +&hdmi0_con {
> > +       remote-endpoint = <&rcar_dw_hdmi0_out>;
> > +};
> 
> I think the hdmi0 and hdmi0_con parts can be moved to salvator-common.dtsi.
> Can we do that now (with stubs?), or does this have to wait until r8a77965 has
> received HDMI sound support?

HDMI sound doesn't use hdmi0_con.
You can do it now, thanks

Best regards
---
Kuninori Morimoto
