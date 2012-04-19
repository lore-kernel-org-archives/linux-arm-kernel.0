From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 19 Apr 2012 13:06:18 -0700
Subject: [PATCH 2/4] clk: remove trailing whitespace from clk.h
In-Reply-To: <1334003101-17274-3-git-send-email-robherring2@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-3-git-send-email-robherring2@gmail.com>
Message-ID: <CAJOA=zOGbttJwSs5n9LZQCjFzJMFZomP0CmzS3PZK0nayCy+Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2012 at 1:24 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Remove trailing whitespace from 2 lines.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Hi Rob,

You asked me to take this patch in the mail thread for the first patch
in this series.  The code being touched here is really Russell's
territory but the change is trivial so I'll take it into my -next
branch.

Regards,
Mike

> ---
> ?include/linux/clk.h | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index b025272..e08bff1 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -220,7 +220,7 @@ void clk_put(struct clk *clk);
> ?* Returns rounded clock rate in Hz, or negative errno.
> ?*/
> ?long clk_round_rate(struct clk *clk, unsigned long rate);
> -
> +
> ?/**
> ?* clk_set_rate - set the clock rate for a clock source
> ?* @clk: clock source
> @@ -229,7 +229,7 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
> ?* Returns success (0) or negative errno.
> ?*/
> ?int clk_set_rate(struct clk *clk, unsigned long rate);
> -
> +
> ?/**
> ?* clk_set_parent - set the parent clock source for this clock
> ?* @clk: clock source
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
