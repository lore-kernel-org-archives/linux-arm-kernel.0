From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Jun 2015 15:13:58 +0200
Subject: [PATCH RFC v2 07/16] arm: domain: Synchronize CPU device runtime
 PM usage with idle state
In-Reply-To: <1435374156-19214-8-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAMuHMdUkhhde52TLH78Y1FOo=BjkjvAmxjQoMAdtrOiUgrR2UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 27, 2015 at 5:02 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> When a CPU is running, the runtime PM usage count should be incremented
> and decremented when the CPU is powers down. To ensure that this happens

powered down

> correctly, increment the runtime usage from that CPU.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
