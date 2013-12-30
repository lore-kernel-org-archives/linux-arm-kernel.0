From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 30 Dec 2013 11:32:41 -0800
Subject: [GIT PULL] clk: keystone: Couple of misc updates for 3.14
In-Reply-To: <1386692618-28584-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386692618-28584-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131230193241.12054.82849@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Santosh Shilimkar (2013-12-10 08:23:37)
> Mike,
> 
> Please find a below small pull request for couple of keystone clock patches
> for 3.14. If you prefer to cherry pick and apply instead thats fine as well.

Pulled into clk-next.

Thanks,
Mike

> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_3.14/keystone-clk
> 
> for you to fetch changes up to e0c223ec67a98f70770eec85e625015f5af69f10:
> 
>   clk: keystone: gate: fix error handling on init (2013-12-10 11:08:20 -0500)
> 
> ----------------------------------------------------------------
> 
> Grygorii Strashko (1):
>   clk: keystone: gate: fix error handling on init
> 
> Murali Karicheri (1):
>   clk: keystone: use clkod register bits for postdiv
> 
>  .../devicetree/bindings/clock/keystone-pll.txt     |    8 +++----
>  drivers/clk/keystone/gate.c                        |   12 ++++++----
>  drivers/clk/keystone/pll.c                         |   24 ++++++++++++++++----
>  3 files changed, 32 insertions(+), 12 deletions(-)
> 
> Regards,
> Santosh
> -- 
> 1.7.9.5
> 
