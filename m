From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 1 Dec 2014 10:36:24 +0100
Subject: [PATCH V3 3/3] ARM: shmobile: Convert to genpd flags for PM
 clocks for R-mobile
In-Reply-To: <1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
 <1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdVntNxw+zciOQfayfJbMMV+AqOyZMqeB2FY=Q5eA=r0rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 9:30 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
> convert to use genpd's flag field and set it to GENPD_PM_CLK.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

(tested on r8a7740/armadillo-multiplatform and sh73a0/kzm9g-multiplatform).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
