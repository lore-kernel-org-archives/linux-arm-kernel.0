From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Jul 2016 10:21:45 +0200
Subject: Build regressions/improvements in v4.7-rc6
In-Reply-To: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
References: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdUDO0k86TTVTiCQGS2=H0dEXVW77NNfvt7fvWbwdpS=2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2016 at 10:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.7-rc6[1] to v4.7-rc5[3], the summaries are:
>   - build errors: +3/-2

  + /home/kisskb/slave/src/drivers/vhost/vhost.c: error: call to
'__compiletime_assert_844' declared with attribute error: BUILD_BUG_ON
failed: __alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE:  => 844:3

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10562/ (260 out of 263 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10532/ (260 out of 263 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
