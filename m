From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:43:19 +0200
Subject: [PATCH 6/6] ARM: dts: atlas6: Add I2S external clock input
 pingroup
In-Reply-To: <1408351765-18253-6-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
 <1408351765-18253-6-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdZ6YQGxBwNXDygb37U5JV1GHWVnan2jb0fZOLbOQbc0tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:49 AM, Barry Song <Baohua.Song@csr.com> wrote:

> From: Rongjun Ying <rongjun.ying@csr.com>
>
> The I2S controller can use the external clock as reference clock with
> master mode. But based on different hardware or software design, this
> external clock might be needed or not needed.
> So the external input pin can be an independent pinctrl group, and the
> card driver can decice to get it or not.
>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please take through platform tree/ARM SoC.

Yours,
Linus Walleij
