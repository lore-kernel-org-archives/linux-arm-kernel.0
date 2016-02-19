From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 10:03:12 +0100
Subject: [PATCH V2 1/2] pinctrl: mediatek: Modify pinctrl bindings for
 mt7623
In-Reply-To: <1455866238-6102-1-git-send-email-blogic@openwrt.org>
References: <1455866238-6102-1-git-send-email-blogic@openwrt.org>
Message-ID: <CACRpkdYiQop2qDNuh4N2YZy2DTy9mOEyERro8hT4YogCPc2LGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 8:17 AM, John Crispin <blogic@openwrt.org> wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree at vger.kernel.org
> ---
> please apply to the devel-mt2701 branch
>
> Changes in V2
> * make mt7623-pinfunc.h part of patch 1/2
> * make sure the list stays sorted

Patch applied unless the Mediatek maintainers come with serious
remarks (I can always revert).

Only minor comments from Yingjoe on the previous version so I guess
it is finished.

MTK guys: do you even have this SoC? It appears MTK is churning out
a plethora of SoCs and then they land in the lap of the OpenWRT
developers before the MTK maintainers even start to look at it...

Yours,
Linus Walleij
