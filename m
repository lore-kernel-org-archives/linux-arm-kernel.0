From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 17:06:34 +0200
Subject: [PATCH 2/2] ARM: realview: Extend PBX family memory description
In-Reply-To: <0acef10ce4429e372ec8c35300c6ec6d48aca7e1.1468583959.git.robin.murphy@arm.com>
References: <dbf8749c4af9aa5ffb85e961b7ae09ffeefa7f2a.1468583959.git.robin.murphy@arm.com>
 <0acef10ce4429e372ec8c35300c6ec6d48aca7e1.1468583959.git.robin.murphy@arm.com>
Message-ID: <CACRpkda8EuC2qfoOydahwWAnBYUX97WPixP85mCQ+04UZq98vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 2:19 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> All three platforms sharing the later RealView Platform Baseboard memory
> map - PBX-A9, PB-A8 and PB11MPCore, provide 512MB of DDR SDRAM on the
> baseboard, of which the boot alias at 0x0 maps the first 256MB. Expand
> the size of the default memory node to refelect that, and describe the
> full memory regions in each board's DTS, but leave those commented by
> default to avoid breaking existing bootloaders.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I've applied this patch for the next kernel cycle. Tweaked the commit
text a bit (removed spelling mistake and prefixed with dts:).

Yours,
Linus Walleij
