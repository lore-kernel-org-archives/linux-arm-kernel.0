From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Jan 2010 08:11:50 +0800
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <20100110172825.GB8639@n2100.arm.linux.org.uk>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
Message-ID: <f17812d71001111611l5b6ebfc8j678e10702a4b0a3d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 1:28 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Most machine classes want some way to register a block of clk_lookup
> structures, and most do it by implementing a clks_register() type
> function which walks an array, or by open-coding a loop.
>
> Consolidate all this into clkdev_add_table().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For PXA part, Acked-by: Eric Miao <eric.y.miao@gmail.com>
