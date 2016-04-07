From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 7 Apr 2016 09:00:00 +0200
Subject: [PATCH] Revert "ARM: dts: porter: Enable SCIF_CLK frequency and
 pins"
In-Reply-To: <1459971126-26622-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1459971126-26622-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CAMuHMdWnJn8-FybRrZH1+72GbyKa-kM_JG6PR01mZHn=4ZNuxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2016 at 9:32 PM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> This reverts commit 19417bd9c5112f58ea63e97ba72edabd5e1cc0fe as
> according to
> http://elinux.org/File:R-CarM2-KOELSCH_PORTER-B_PORTER_C_Comparison.pdf
> the external oscilator for SCIF_CLK is not mounted on the porter boards.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
