From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 20 Jun 2013 23:19:29 -0700
Subject: [PATCH v2] clk: tegra: Use common of_clk_init function
In-Reply-To: <51B6CF60.9020600@nvidia.com>
References: <1369640409-1981-1-git-send-email-pgaikwad@nvidia.com>
 <51A4CA6A.8090103@wwwdotorg.org> <51B6CF60.9020600@nvidia.com>
Message-ID: <20130621061929.9136.10202@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Prashant Gaikwad (2013-06-11 00:18:56)
> On Tuesday 28 May 2013 08:46 PM, Stephen Warren wrote:
> > On 05/27/2013 01:40 AM, Prashant Gaikwad wrote:
> >> Use common of_clk_init() function for clocks initialization.
> 
> Mike,
> 
> Please merge this patch in your tree.

Hi Prashant. I merged this one a long time ago:

Refs: v3.10-rc3-22-g061cec9
Author:     Prashant Gaikwad <pgaikwad@nvidia.com>
AuthorDate: Mon May 27 13:10:09 2013 +0530
Commit:     Mike Turquette <mturquette@linaro.org>
CommitDate: Fri May 31 12:57:25 2013 -0700

Regards,
Mike

> 
> Thanks,
> PrashantG
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
