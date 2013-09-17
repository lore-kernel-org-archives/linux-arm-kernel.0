From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Sep 2013 13:24:29 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable ARM_ATAG_DTB_COMPAT
In-Reply-To: <1379347284-12422-1-git-send-email-olof@lixom.net>
References: <1379347284-12422-1-git-send-email-olof@lixom.net>
Message-ID: <CACRpkdb+0R=dqg6=obRk0pGaz0Bv+3=9pEbY0iMOy+4xq=_VJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 6:01 PM, Olof Johansson <olof@lixom.net> wrote:

> Without this, legacy platforms that can boot with a multiplatform
> kernel but that need the DTB to be appended, won't have a way to pass
> firmware-set bootargs to the kernel.
>
> This is needed to boot multi_v7_defconfig on snowball, for instance.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
