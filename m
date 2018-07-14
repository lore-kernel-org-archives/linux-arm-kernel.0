From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2018 12:49:07 +0200
Subject: [PATCH -next] pinctrl: nsp: fix potential NULL dereference in
 nsp_pinmux_probe()
In-Reply-To: <14329d52-72bb-3594-dec3-00ab0f7ccd40@broadcom.com>
References: <1531312461-134547-1-git-send-email-weiyongjun1@huawei.com>
 <CACRpkdbwAJOaFay3x45gyf7rBpkPOAMbxW6FLQUvCekUKatLYA@mail.gmail.com>
 <14329d52-72bb-3594-dec3-00ab0f7ccd40@broadcom.com>
Message-ID: <CACRpkdaSgwLhwwHEKHJfrWSHcQ+SAZPtkOreP88wtDKuMgTVcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 6:53 PM Ray Jui <ray.jui@broadcom.com> wrote:

> > Patch applied with Ray's ACK.
>
> Would be nice to add the following Fixes tag:
>
> Fixes: cc4fa83f66e9 ("pinctrl: nsp: add pinmux driver support for
> Broadcom NSP SoC")

OK fixed it!

Yours,
Linus Walleij
