From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Sep 2014 13:38:04 +0200
Subject: [PATCH v2 1/1] gpio: Fix ngpio in gpio-xilinx driver
In-Reply-To: <1411513125-20712-1-git-send-email-gvormayr@gmail.com>
References: <1411031032-20649-1-git-send-email-gvormayr@gmail.com>
 <1411513125-20712-1-git-send-email-gvormayr@gmail.com>
Message-ID: <CACRpkdYW17RtVEfGia8Lp2RE3WB1_TPone5ZHbY86WQ2RLezYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 12:58 AM, Gernot Vormayr <gvormayr@gmail.com> wrote:

> If one adds gpio-controller; to the chip in the devicetree, then
> initialization fails with 'gpiochip_find_base: cannot find free range',
> because ngpio is 0. This patch fixes the bug.
>
> This version includes the suggestions from Linus Walleij.
>
> Tested on ml507 board.
>
> Signed-off-by: Gernot Vormayr <gvormayr@gmail.com>

Patch applied.

Yours,
Linus Walleij
