From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 11 Apr 2013 12:42:29 +0200
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAMuHMdWFVi=AFR8prins0mees4BFUUXirCC2swyQPwGs7Tt8uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 4:39 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> +       { "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },

Why "r5g6b5" instead of "rgb565", which is what's commonly used?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
