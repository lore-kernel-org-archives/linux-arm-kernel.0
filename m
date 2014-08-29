From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:41:49 +0200
Subject: [PATCH 4/6] ARM: dts: atlas6: add a separate pingroup for i2s
 mclk output
In-Reply-To: <1408351765-18253-4-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
 <1408351765-18253-4-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdb-10u7wq2nbC8DEfSY0na6=RkN8_J7EY=Jm8FZ8jukiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:49 AM, Barry Song <Baohua.Song@csr.com> wrote:

> From: Rongjun Ying <rongjun.ying@csr.com>
>
> The I2S controller can output mclk to external audio codec. But by
> hardware design, some codecs need mclk and some codecs do not need
> mclk. So the mclk pin can be an independent pinctrl group, and the
> card driver can get it or not based on boards.
>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls take this through the ARM SoC tree / Sirf platform tree.

Yours,
Linus Walleij
