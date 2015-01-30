From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 30 Jan 2015 13:23:01 +0100
Subject: [PATCH] spi/xilinx: Fix access invalid memory on xilinx_spi_tx
In-Reply-To: <CAMuHMdU7=w1C6xjDhHwaFmw7Ct4OwfUHCKr8KsZKEoLZzfpf0Q@mail.gmail.com>
References: <1422598209-5999-1-git-send-email-ricardo.ribalda@gmail.com>
 <CAMuHMdU7=w1C6xjDhHwaFmw7Ct4OwfUHCKr8KsZKEoLZzfpf0Q@mail.gmail.com>
Message-ID: <CAPybu_3W3pSBLCxnVKyPVgnFQkitYMGu=xYbX+PpeTZcQH1oXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 Jan 2015 11:06, "Geert Uytterhoeven" <geert@linux-m68k.org> wrote:

> Is this endian-safe?

As endianness safe as the original code, but there is also an issue. It is
using rx_ptr.

I am away until  Sunday. So I cannot make a new patch until then. I tried
to make this patch before leaving in the morning and was obviously a
mistake.

Again, Sorry for the mess this is really embarrassing.
Regards
>         xspi->tx_ptr += xspi->bytes_per_word;

> >  }
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert at linux-m68k.org <javascript:;>
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                 -- Linus Torvalds
>
