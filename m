From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Feb 2017 13:26:16 +0100
Subject: [PATCH 00/22] Conversion of ARMv4 Gemini to DT and multiplatform
In-Reply-To: <alpine.LNX.2.00.1702081401080.8463@T420s>
References: <20170122121506.9995-1-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1702081401080.8463@T420s>
Message-ID: <CACRpkdYsFDxk_mmWtWi6qtpmuiNr9nzNvt0auMEmbWapR=K+Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 2:13 PM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:

> now I've got my toolchain cleaned up and working ...
> Tested on may nas 4220
>
> here my
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

Thanks! I'll add it throughout.

>> - FOT2G USB EHCI host
>
> The fotg2 driver is already upstream.
> I've added DT support and this driver works.

I saw some patches flying, awesome. I'll probably stack them up in
my git tree. I can't test them: the SQ201 I'm using has a separate
VIA USB on PCI for some reason, I guess they just didn't trust the
built-in USB and just threw money at the problem.

With the patches in transit the upstream TODO (not started) is just
down to:
- SATA
- Ethernet
- Crypto

Yours,
Linus Walleij
