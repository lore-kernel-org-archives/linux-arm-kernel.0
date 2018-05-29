From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 29 May 2018 08:48:43 +0200
Subject: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
In-Reply-To: <8736yb5jez.wl%kuninori.morimoto.gx@renesas.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
 <8736yb5jez.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CAMuHMdWPFOjT9qk0Z4+-nSTumjhN_Q6Ntwh3__CgBCobquX8Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

On Tue, May 29, 2018 at 3:44 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > +&hdmi0_con {
>> > +       remote-endpoint = <&rcar_dw_hdmi0_out>;
>> > +};
>>
>> I think the hdmi0 and hdmi0_con parts can be moved to salvator-common.dtsi.
>> Can we do that now (with stubs?), or does this have to wait until r8a77965 has
>> received HDMI sound support?
>
> HDMI sound doesn't use hdmi0_con.
> You can do it now, thanks

Thanks, so hdmi0_con can be moved now.

But HDMI sound does use hdmi0/ports/port at 2. right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
