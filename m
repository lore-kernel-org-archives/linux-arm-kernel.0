From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Sep 2014 10:47:18 +0200
Subject: [PATCH v3 05/13] PM / Domains: Add helper variable np =
 dev->of_node
In-Reply-To: <CAPDyKFpiTBKEJHTF9cK20GTqEgx=4UNt52sKi0dQ7NsZNhfFOA@mail.gmail.com>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
 <1411662520-22795-6-git-send-email-geert+renesas@glider.be>
 <CAPDyKFpiTBKEJHTF9cK20GTqEgx=4UNt52sKi0dQ7NsZNhfFOA@mail.gmail.com>
Message-ID: <CAMuHMdUEA07weFje47u4sJ6uc0FCvoq+FEe27DSmKOVB0dTatA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 10:43 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 September 2014 18:28, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> Why?

Because else the next patch would add a few more users of dev->of_node.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
