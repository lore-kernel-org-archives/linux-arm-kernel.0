From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 2 May 2017 11:27:58 +0200
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Enable NFS root
In-Reply-To: <1493717048-10740-1-git-send-email-horms+renesas@verge.net.au>
References: <1493717048-10740-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXbvC90k1QYZsjWx=f7QVQyWOzi_v3u8ShDoDsSAmZsjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, May 2, 2017 at 11:24 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Enable NFS root on the r8a7795/h3ulcb and r8a7796/m3ulcb
> as per:
> * commit b2407c566ba29215 ("arm64: dts: r8a7795: enable nfs root on Salvator-X board").
> * commit 742a9dfb90f0 ("arm64: dts: r8a7796: salvator-x: Enable NFS root")
>
> Also set ignore_loglevel rw as boot args as is the case for the boards
> for the boards for other Renesas ARM/ARM64 based SoCs.

s/for the boards//

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
