From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 12:17:09 +0100
Subject: [PATCH 3/3] arm: mvebu: enable gpio expander over i2c on Mirabox
 platform
In-Reply-To: <1357493688-25061-4-git-send-email-gregory.clement@free-electrons.com>
References: <1357493688-25061-1-git-send-email-gregory.clement@free-electrons.com>
 <1357493688-25061-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdZMLQvKSgsGuBqw=O64iZ-yXD-TqetNdv-35BXoGKWkOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 6, 2013 at 6:34 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Globalscale Mirabox platform can be connected to the JTAG/GPIO box
> through the Multi-IO port. The GPIO box use the NXP PCA9505 I/O port
> expansion IC to provide 40-bit parallel input/output GPIOs. This patch
> enable the use of this expander on the Mirabox.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls merge through the Marvell tree or whatever ARM subtree makes sense.

Yours,
Linus Walleij
