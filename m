From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 09:17:57 +0100
Subject: [PATCH v3 3/3] arm: mvebu: enable gpio expander over i2c on
 Mirabox platform
In-Reply-To: <1358889025-8530-4-git-send-email-gregory.clement@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdbBOQ_KE001kfORapo9=WiJYn04MmRhxnn-5v8ki-EeyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:10 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Globalscale Mirabox platform can be connected to the JTAG/GPIO box
> through the Multi-IO port. The GPIO box use the NXP PCA9505 I/O port
> expansion IC to provide 40-bit parallel input/output GPIOs. This patch
> enable the use of this expander on the Mirabox.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

So as requested I leave this patch for now, tell me if you want it
applied through pinctrl.

Yours,
Linus Walleij
