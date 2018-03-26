From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Mar 2018 10:57:51 +0200
Subject: [PATCH v4 4/5] pintcrl: support bias-disable of generic and
 special pins simultaneously
In-Reply-To: <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
 <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <CACRpkdZoZD-1D_o2wJd-JpmTpm-EBTQu5=ndrN1KeTvPwHGPdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 3:58 AM, Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> For generic pins, parameter "arg" is 0 or 1.
> For special pins, bias-disable is set by R0R1,
> so we need transmited "00" to set bias-disable
> When we set "bias-disable" as high-z property,
> the parameter should be "MTK_PUPD_SET_R1R0_00".
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Patch applied for v4.17 with Sean's Review tag.

Yours,
Linus Walleij
