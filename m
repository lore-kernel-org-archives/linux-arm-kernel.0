From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 22 Jan 2013 10:13:19 +0000
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <CACRpkdY4MHLjs1Lnj+8Ts6oZOjG14pDssCQ09PX-a_5nGRs1sg@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdb=vf5s-XmfYYn5W-BjeNaf9vw6-sDSH6VDC41PBX0rdQ@mail.gmail.com>
 <1358785488.6590.33.camel@hornet>
 <CACRpkdY4MHLjs1Lnj+8Ts6oZOjG14pDssCQ09PX-a_5nGRs1sg@mail.gmail.com>
Message-ID: <1358849599.6590.65.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-22 at 09:42 +0000, Linus Walleij wrote:
> AFAICT gpio_request() will return -EPROBE_DEFER if the GPIO
> cannot be located.

If it does, I withdraw all my objections.

Cheers!

Pawe?
