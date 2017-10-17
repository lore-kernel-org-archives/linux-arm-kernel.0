From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 21:26:45 +0800
Subject: [PATCH v4 2/5] reset: sunxi: use reset-simple driver
In-Reply-To: <20171017130306.881-3-p.zabel@pengutronix.de>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
 <20171017130306.881-3-p.zabel@pengutronix.de>
Message-ID: <CAGb2v66sKTyHF=yVoyvsQ+Cj+wBSYhM+pRcXqZF-i0v5uwxJpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 9:03 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Use the newly created copies in the reset-simple driver to replace the
> sunxi platform driver code and reset operations. The separate sunxi
> driver still remains to register the early reset controllers, but it
> reuses the reset operations in reset-simple.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Though to be honest this won't get much testing...

We've converted all sunxi SoCs over to the new sunxi-ng clk dt-bindings
and drivers, which include the reset controls as well.
