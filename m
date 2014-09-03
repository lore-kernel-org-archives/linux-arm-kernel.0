From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Sep 2014 10:08:31 -0700
Subject: [GIT PULL] clk: ti: dra7xx: fixes for early 3.17-rc
In-Reply-To: <5406CDD4.8000103@ti.com>
References: <5406CDD4.8000103@ti.com>
Message-ID: <20140903170831.11368.8180@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2014-09-03 01:14:12)
> Hi Mike,
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>    Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>    git at github.com:t-kristo/linux-pm.git for-v3.17-rc/ti-clk-driver
> 
> for you to fetch changes up to 20411dad75ece9a613af715df4489e60990c4017:
> 
>    clk: ti: dra7-atl: Provide error check for incoming parameters in 
> set_rate (2014-08-21 18:04:16 +0300)

Pulled into clk-fixes.

Thanks,
Mike

> 
> ----------------------------------------------------------------
> Just a couple of quick error check fixes for dra7 boards. Proper fix 
> would be required for the generic clock driver as well (see 
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg108454.html.)
> 
> ----------------------------------------------------------------
> Nishanth Menon (2):
>        clk: ti: divider: Provide error check for incoming parameters in 
> set_rate
>        clk: ti: dra7-atl: Provide error check for incoming parameters in 
> set_rate
> 
>   drivers/clk/ti/clk-dra7-atl.c |    6 +++++-
>   drivers/clk/ti/divider.c      |    7 ++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
