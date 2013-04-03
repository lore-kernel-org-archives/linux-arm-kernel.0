From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:34:24 +0200
Subject: [PATCH 3/9] ARM: ux500: Supply a DTS file for the u8540 platform
In-Reply-To: <1364908916-29803-3-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdafSvT5Xb=7sqnkRHcc4UKkVzr8jzThMgWn6459RDmKGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This is a skeleton DTS file which only enables serial. Just using
> this simple file yields a terminal when booting u8540.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/u8540.dts |   36 ++++++++++++++++++++++++++++++++++++

Please rename this DTS file ccu8540.dts.

Yours,
Linus Walleij
