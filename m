From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Jun 2014 09:05:42 +0200
Subject: [PATCH v2 0/7] ARM: shmobile: koelsch reference: Enable DMA for
 QSPI
In-Reply-To: <538D50D1.7010900@renesas.com>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <538D50D1.7010900@renesas.com>
Message-ID: <CAMuHMdVnmsjf29X4KF0co+WwUh9i0DQe6hE0hNFMCv-+GeHP_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 3, 2014 at 6:36 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> I think this patch series should be divided into 2 parts,
> one for DMA in general and one for DMA supporting QSPI.
>
> How do you think about it ?

I don't think it's worth splitting off just the last patch into a separate
series.

This is a series, not a single patch. The applyer can always drop some
patches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
