From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 10:09:07 +0100
Subject: [PATCH V2 2/2] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver
 for MT7623
In-Reply-To: <1455866238-6102-2-git-send-email-blogic@openwrt.org>
References: <1455866238-6102-1-git-send-email-blogic@openwrt.org>
 <1455866238-6102-2-git-send-email-blogic@openwrt.org>
Message-ID: <CACRpkdbK7vJDgVHFaQFcULtUmBKN_b_Z5usgYVk67jxH-cKwaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 8:17 AM, John Crispin <blogic@openwrt.org> wrote:

> Add the driver and header files required to make pinctrl work on MediaTek
> MT7623.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> please apply to the devel-mt2701 branch
>
> Changes in V2
> * fix typo in Kconfig
> * move mt7623-pinfunc.h into 1/2

Patch applied, thanks for your efforts to support this SoC.
I had to do some manual fixup for Makefile, I think it looks
allright now.

Yours,
Linus Walleij
