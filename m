From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 10:18:24 +0100
Subject: [PATCH 08/12] ARM: ux500: Specify which IOS regulator to use for
 MMCI
In-Reply-To: <1355129761-8088-9-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbTunT3h9qUz3t6dO4YXLYAnrThpwWNSFMqrVyf4uRggQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 9:55 AM, Lee Jones <lee.jones@linaro.org> wrote:

> In an effort to move platform specific GPIO controlled regulators
> out from platform code we've created a new mechanism to specify
> them from within the MMCI driver using the supply name 'vmmc-ios'.
> For that to happen when booting device tree, we need to supply it
> in the MMCI (SDI) node.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
