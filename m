From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 11:30:31 +0100
Subject: [RFC 34/37] ARM: dts: r8a7791: Add watchdog support to SoC dtsi
In-Reply-To: <1516903391-30467-35-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-35-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdWLGthxoePFg2fLyuKq1UkgorvMe+BqHPaBjzv8c=w6Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 7:03 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This commit adds watchdog support to the r8a7791 dtsi.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

If inserted before gpio at e6050000:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
