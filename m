From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Feb 2016 12:31:59 +0000
Subject: [PATCH] soc: dove: Make reset_control_ops const
In-Reply-To: <1456393568-28363-1-git-send-email-p.zabel@pengutronix.de>
References: <1456393568-28363-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20160225123159.GB7219@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Feb 25, 2016 at 10:46:08AM +0100, Philipp Zabel wrote:
> The pmu_reset_ops structure is never modified. Make it const.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Since commit 203d4f347d86 ("reset: Make reset_control_ops const") marked
> the ops pointer in struct reset_controller_dev as const, this struct can
> be made const, too. The commit is currently sitting in the
> arm-soc/for-next branch.

Please include this in the commit body.  All except the last sentence.

> ---
>  drivers/soc/dove/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With that,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
