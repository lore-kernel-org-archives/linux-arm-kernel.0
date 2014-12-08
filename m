From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Mon, 8 Dec 2014 20:53:50 +0900
Subject: [PATCH] clk: shmobile: Add r8a7793 support
In-Reply-To: <CAMuHMdVDA4PwUZ8A0WPumEN9nYrQyX+UNYp7Dt=0TxO9nCuZrg@mail.gmail.com>
References: <1418035363-3678-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdVDA4PwUZ8A0WPumEN9nYrQyX+UNYp7Dt=0TxO9nCuZrg@mail.gmail.com>
Message-ID: <CAH1o70JgXPfRVQ+EyeQVA6Sa9irDb3hVBn7vAbDDuu7k=Z7x3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert-san,

2014-12-08 20:13 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Kaneko-san,
>
> On Mon, Dec 8, 2014 at 11:42 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>
>> R-Car M2N (r8a7793) clock is handled in R-Car Gen2 clock driver.
>
> Thanks for your patch!
>
>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Can you please also send a patch to update the binding documentation in
> Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt?

This patch updates Makefile only, not added dtsi for r8a7793.
Is the update of the document necessary?

Thanks,
Kaneko

>
> Thanks again!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
