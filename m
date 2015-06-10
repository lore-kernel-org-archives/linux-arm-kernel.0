From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 10:57:25 +0200
Subject: [PATCH 08/34] pinctrl: mvebu: armada-38x: fix incorrect total
 number of GPIOs
In-Reply-To: <1433868446-11028-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdatecpaay7p3Y2vJywp3LEA8DXH4OJs3W=e5_Gc+RL7Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:47 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> The pinctrl_gpio_range[] array described a first bank of 32 GPIOs and
> a second one of 27 GPIOs. However, since there is a total of 60 MPP
> pins that can be muxed as GPIOs, the second bank really has 28 GPIOs.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.15+
> Fixes: ca6d9a084b56f ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 380/385")

Patch applied.

Yours,
Linus Walleij
