From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 16:27:41 +0200
Subject: [PATCH 07/11] ARM: mvebu: Add pinctrl support to Armada XP SoCs
In-Reply-To: <1344689809-6223-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdbNpeBLy-JmUz-YjFYVZfAw3mavUAWigLKyXU=iQ_wMSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> This commits adds the necessary device tree information to define the
> compatible property for the pinctrl driver instance of Armada XP SoCs.
>
> Until now, the device tree representation considered the Armada XP as
> a single SoC. But in fact, there are three different SoCs in the
> Armada XP families, with different number of CPU cores, different
> number of Ethernet interfaces... and different number of muxable pins
> or functions. We therefore introduce three armada-xp-mv78xx0.dtsi for
> the three SoCs of the Armada XP family. The current armada-xp-db.dts
> evaluation board uses the MV78460 variant of the SoC.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
