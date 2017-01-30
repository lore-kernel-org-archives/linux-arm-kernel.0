From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 14:58:02 +0100
Subject: [PATCH v6 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <20170129232035.25189-4-chris.packham@alliedtelesis.co.nz>
References: <20170129232035.25189-1-chris.packham@alliedtelesis.co.nz>
 <20170129232035.25189-4-chris.packham@alliedtelesis.co.nz>
Message-ID: <CACRpkdavkH21iuxde-KUQJeX9S03Z_9CaUQe6h9e9C7Cup_AEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 12:20 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>
> This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
> from Marvell.
>
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>
> Notes:
>     Changes in v2:
>     - include sdio support for the 98DX4251
>     Changes in v3:
>     - None
>     Changes in v4:
>     - Correct some discrepencies between binding and driver.
>     - Collect acks from Rob and Sebastian
>     Changes in v5:
>     - Update bindings to reflect "gpo" pins
>     - Use mvebu_mmio_mpp_ctrl instead of armada_xp_mpp_ctrl (note this is reliant
>       on changes queued in linux-pinctrl)
>     Changes in v6:
>     - None

This patch was applied to an immutable branch and then merged into the
pinctrl devel tree. The immutable branch is here:

https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-mvebu-98dx3236

Do as you please: if you want other trees (ARM SoC) to pull this in or
not.

Yours,
Linus Walleij
