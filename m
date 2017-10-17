From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 21:27:49 +0800
Subject: [PATCH v4 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <20171017130306.881-2-p.zabel@pengutronix.de>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
 <20171017130306.881-2-p.zabel@pengutronix.de>
Message-ID: <CAGb2v64dqnSazEj-zS5OXcNBG+SYgFoARqfAuO_B4CnhMGMgNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 9:03 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Copy reusable parts from the sunxi driver, to add a driver for simple
> reset controllers with reset lines that can be controlled by toggling
> bits in exclusive, contiguous register ranges using read-modify-write
> cycles under a spinlock.
>
> The following patches will replace compatible reset drivers with
> reset-simple, extending it where necessary.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
