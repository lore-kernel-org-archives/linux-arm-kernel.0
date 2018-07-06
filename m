From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 6 Jul 2018 21:38:40 +0200
Subject: [PATCH] dma: stm32: replace "%p" with "%pK"
In-Reply-To: <20180706130220.21957-1-benjamin.gaignard@st.com>
References: <20180706130220.21957-1-benjamin.gaignard@st.com>
Message-ID: <CAMuHMdVEOx=PLAHzGEtPmVtitsVYSc-F1TUP6DVCS=Ct7QupYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On Fri, Jul 6, 2018 at 3:03 PM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

Still? Isn't the value randomized these days?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
