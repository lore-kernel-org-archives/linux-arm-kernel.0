From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:39:50 +0200
Subject: [PATCH 5/9] ARM: ux500: Over-ride TCDM size when booting the
 DB8540 platform
In-Reply-To: <1364908916-29803-5-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbh-DJti2ny=uBe-b_vGkQBNL=emMuZ6+_cE5jvRsA4sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The PRCMU's Tightly Coupled Data Memory on the DB8540 platform is
> 8kB larger than it's predecessor's. We need to reflect that in its
> Device Tree. By re-specifying the address and size of the device
> we effectively over-ride the previous values with more accurate
> ones.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Need to change the name of the file it hits to ccu8540 before
it applies...

Yours,
Linus Walleij
