From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Apr 2014 14:52:20 +0200
Subject: [PATCH v2 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdbT94HqVroM_0gSJJ8Q2+YaKXLwjFGMn+4SCa_PYiF19Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 5:51 PM, Antoine T?nart
<antoine.tenart@free-electrons.com> wrote:

> This series adds support for the Marvell Berlin pin-controller, allowing
> to configure the pin muxing from the device tree.
>
> The Berlin pin-controller support is divided into 3 drivers, each
> driving one Berlin SoC. These drivers use a Berlin common part.
>
> This series applies on top of patches introducing the Marvell Berlin
> BG2Q you can find on Sebastian's berlin/for-next branch[1] and the patch
> allowing not to define the get_group_pins() function[2].
>
> Tested on the Berlin BG2Q.

So now I need some advice from the mvebu pinctrl maintainers
(Thomas, Sebastian etc):

- Is this a totally different pin controller so that drivers/pinctrl/mvebu
 can not be used?

- Really?

- OK can you help me review this thing?

- Should the base folder really be named "berlin" or is this going to
  be part of a bigger family of pin controllers so a more neutral name
  should be sought?

- Why do hardware engineers seek to reinvent wheels like pin
  controllers, GPIO and DMA engines all the time :-/

Yours,
Linus Walleij
