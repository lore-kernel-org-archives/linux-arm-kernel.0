From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 26 Mar 2014 21:37:08 -0700
Subject: [PATCH 0/3] clk: mmp: bug fix for clk-frac
In-Reply-To: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
References: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20140327043708.5762.44142@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chao Xie (2014-01-22 18:47:39)
> From: Chao Xie <chao.xie@marvell.com>
> 
> When use the clk-frac type of mmp, some bugs are found.
> The following 3 patches are bug fix for clk-frac

Taken into clk-next!

Regards,
Mike

> 
> Chao Xie (3):
>   clk: mmp: fix wrong mask when calculate denominator
>   clk: mmp: fix the wrong calculation formula
>   clk: mmp: try to use closer one when do round rate
> 
>  drivers/clk/mmp/clk-frac.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> -- 
> 1.8.3.2
> 
