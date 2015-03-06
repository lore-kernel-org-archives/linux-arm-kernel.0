From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Mar 2015 12:12:53 +0100
Subject: [PATCH v3 15/20] pinctrl: mvebu: add pinctrl driver for Marvell
 Armada 39x
In-Reply-To: <1425393675-17820-16-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1425393675-17820-16-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaWAu1jF8Tjx8x=rQTvux2FGiFEkfFXDz5DGwkiFWW8GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 3:41 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit adds a new pinctrl driver for the Marvell Armada 39x
> family of processors, which hooks into the existing infrastructure to
> support pin-muxing on Marvell EBU processors. Two variants of the
> Armada 39x are supported: 88F6920 (Armada 390) and 88F6928 (Armada
> 398), which have a few differences in the available functions for
> certain pins.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Already applied this some time ago...

Yours,
Linus Walleij
