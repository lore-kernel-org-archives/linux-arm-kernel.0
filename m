From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 09:43:48 +0200
Subject: [PATCH -next] pinctrl: at91-pio4: remove redundant return value
 check of platform_get_resource()
In-Reply-To: <1531312447-134423-1-git-send-email-weiyongjun1@huawei.com>
References: <1531312447-134423-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <CACRpkdb7zWv10Fnr_M4zSKmhHQ=QmJTOAJsqgCPguAdCuU=4iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 2:25 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
