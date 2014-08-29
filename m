From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:40:42 +0200
Subject: [PATCH 3/6] pinctrl: atlas6: take mclk pin out of i2s pingroup
In-Reply-To: <1408351765-18253-3-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
 <1408351765-18253-3-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdZ9-NAsd4=89pC0B9wXNs_pQbs9qeP84ZGXsnWKgtPjgQ@mail.gmail.com>
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

Patch applied.

Yours,
Linus Walleij
