From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 12:45:04 +0200
Subject: [PATCH v2] ARM: ux500: Apply other compatible name to the u8540
 DTS file
In-Reply-To: <20130522144957.GA18714@gmail.com>
References: <1369233402-19225-1-git-send-email-lee.jones@linaro.org>
 <20130522144957.GA18714@gmail.com>
Message-ID: <CACRpkda_mcNYB8iqE8Pvxp_pQZejGvdXQRxiL1QMO5vZcGgMhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 4:49 PM, Lee Jones <lee.jones@linaro.org> wrote:

> ARM: ux500: Apply other compatible name to the u8540 DTS file
>
> Devices in board DTS files are usually searchable by multiple
> compatible strings. In this case the 8540 based SoC should be
> obtainable via the chipset [DB8540 & AB8540] name 'u8540' or
> the board name 'ccu8540'. It's already possible to obtain the
> Device Tree via its chipset name, this patch makes it possible
> to get it by its board name too.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-devicetree branch.

Thanks!
Linus Walleij
