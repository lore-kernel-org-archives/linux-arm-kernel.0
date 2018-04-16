From: jacopo@jmondi.org (jacopo mondi)
Date: Mon, 16 Apr 2018 15:07:21 +0200
Subject: [PATCH v2 15/19] dt-bindings: gpio: Add support for r8a77965
In-Reply-To: <CAMuHMdW4k+GROdy6kKT-3jd7YYGVbKvieyCSEWXGXJyvZg7NGQ@mail.gmail.com>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdW4k+GROdy6kKT-3jd7YYGVbKvieyCSEWXGXJyvZg7NGQ@mail.gmail.com>
Message-ID: <20180416130721.GB3377@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Mon, Apr 16, 2018 at 01:12:06PM +0200, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Can you please resend to the GPIO maintainer?
> Thanks!

Thank you for the useful reminder.

>From my original M3-N support series, the following DT binding patches
have actually to be resent, now that the SoC support is in v4.17-rc1.

dt-bindings: dmaengine: rcar-dmac: document R8A77965 support
dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
dt-bindings: net: ravb: Add support for r8a77965 SoC
dt-bindings: gpio: Add support for r8a77965

I will resend each one to the appropriate tree maintainer.

Thanks
   j


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180416/ac02c299/attachment.sig>
