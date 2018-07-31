From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 31 Jul 2018 11:24:45 -0300
Subject: [PATCH v2 0/6] perf cs-etm: Fix tracing packet handling and
 minor refactoring
In-Reply-To: <20180723013507.GA27713@leoy-ThinkPad-X240s>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
 <20180723013507.GA27713@leoy-ThinkPad-X240s>
Message-ID: <20180731142445.GB4909@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, Jul 23, 2018 at 09:35:07AM +0800, leo.yan at linaro.org escreveu:
> Hi Arnaldo,
> 
> On Wed, Jul 11, 2018 at 03:45:39PM +0800, Leo Yan wrote:
> 
> Just want to confirm, I saw the first two patches in this serise have
> been merged into perf/core branch [1], but the last 4 patches are
> missed.
> 
> Could I know if you have trouble when you apply them?  Or anything
> need me to follow up?  Otherwise you might miss them :)

Just this reminder was enough, checked that it has Mathieu's reviewed-by
tags, applied, will go thru my cross build containers, hopefully all
will test build ok and then it'll go to Ingo's direction.

Thanks,

- Arnaldo
