From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:38:11 +0200
Subject: [PATCH 1/6] pinctrl: sirf: fix "quoted string split across lines"
In-Reply-To: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdbVUMFZJn25aoz-gMw74FeAC1DuuZUhWv1fKwegriU9cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:49 AM, Barry Song <Baohua.Song@csr.com> wrote:

> From: Bin Shi <Bin.Shi@csr.com>
>
> this patch fixes:
> WARNING: quoted string split across lines
> 902: FILE: drivers/pinctrl/sirf/pinctrl-sirf.c:902:
> +MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>, "
> +       "Yuping Luo <yuping.luo@csr.com>, "
>
> WARNING: quoted string split across lines
> 903: FILE: drivers/pinctrl/sirf/pinctrl-sirf.c:903:
> +       "Yuping Luo <yuping.luo@csr.com>, "
> +       "Barry Song <baohua.song@csr.com>");
>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied.

Yours,
Linus Walleij
