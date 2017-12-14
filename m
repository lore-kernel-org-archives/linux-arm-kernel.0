From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 14 Dec 2017 10:57:17 +0100
Subject: [PATCH v7 1/6] clk: meson: make the spinlock naming more specific
In-Reply-To: <20171211141348.22048-2-yixun.lan@amlogic.com>
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
 <20171211141348.22048-2-yixun.lan@amlogic.com>
Message-ID: <1513245437.32163.0.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 22:13 +0800, Yixun Lan wrote:
> Make the spinlock more specific, so better for lockdep
> debugging and ctags/grep.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to next/drivers

Thx

> 
> ---
> 
> this patch try to address the issue which bring up by Stephen at [1]
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005534.html
> ---
>  drivers/clk/meson/clkc.h    |   2 +-
>  drivers/clk/meson/gxbb.c    | 112 ++++++++++++++++++++++----------------------
>  drivers/clk/meson/meson8b.c |  24 +++++-----
>  3 files changed, 69 insertions(+), 69 deletions(-)
