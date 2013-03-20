From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 20 Mar 2013 09:44:38 -0700
Subject: [PATCH 1/1] documentation: clk: fix couple of misspelling
In-Reply-To: <1362059947-3706-1-git-send-email-eduardo.valentin@ti.com>
References: <1362059947-3706-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <20130320164438.18043.5312@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Eduardo Valentin (2013-02-28 05:59:07)
> Correcting misspelling inside the clk.txt.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Thanks Eduardo!  Taken into clk-next.

Regards,
Mike

> ---
>  Documentation/clk.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> index 1943fae..4274a54 100644
> --- a/Documentation/clk.txt
> +++ b/Documentation/clk.txt
> @@ -174,9 +174,9 @@ int clk_foo_enable(struct clk_hw *hw)
>  };
>  
>  Below is a matrix detailing which clk_ops are mandatory based upon the
> -hardware capbilities of that clock.  A cell marked as "y" means
> +hardware capabilities of that clock.  A cell marked as "y" means
>  mandatory, a cell marked as "n" implies that either including that
> -callback is invalid or otherwise uneccesary.  Empty cells are either
> +callback is invalid or otherwise unnecessary.  Empty cells are either
>  optional or must be evaluated on a case-by-case basis.
>  
>                             clock hardware characteristics
> -- 
> 1.7.7.1.488.ge8e1c
