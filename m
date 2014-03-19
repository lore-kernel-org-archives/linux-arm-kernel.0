From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Mar 2014 13:57:58 -0700
Subject: pull request on hisilicon clock driver
In-Reply-To: <CAN1soZxL61veKXCqB1r4Vjy3RcLOQDJK9qDpm6-Dog6jH_v1UA@mail.gmail.com>
References: <CAN1soZxL61veKXCqB1r4Vjy3RcLOQDJK9qDpm6-Dog6jH_v1UA@mail.gmail.com>
Message-ID: <20140319205758.31449.31775@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Haojian Zhuang (2014-03-19 00:51:22)
> Hi Mike,
> 
> Please help to merge the pull request on hisilicon clock driver.
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
> tags/clk-hisi

Taken into clk-next.

Regards,
Mike

> 
> for you to fetch changes up to 75af25f581b1ffc63e06cb01547b3141d4cd5f58:
> 
>   clk: hisi: remove static variable (2014-03-19 15:31:27 +0800)
> 
> ----------------------------------------------------------------
> updating clock drivers for Hisilicon
> 
> ----------------------------------------------------------------
> Haojian Zhuang (3):
>       clk: hisi: assign missing clk to table
>       clk: hip04: add clock driver
>       clk: hisi: remove static variable
> 
>  drivers/clk/Makefile                    |  1 +
>  drivers/clk/hisilicon/Makefile          |  5 ++++-
>  drivers/clk/hisilicon/clk-hi3620.c      | 25 ++++++++-----------------
>  drivers/clk/hisilicon/clk-hip04.c       | 58
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/hisilicon/clk.c             | 62
> +++++++++++++++++++++++++++++++++++++++++++++++---------------
>  drivers/clk/hisilicon/clk.h             | 17 +++++++++++------
>  include/dt-bindings/clock/hip04-clock.h | 35
> +++++++++++++++++++++++++++++++++++
>  7 files changed, 164 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/clk/hisilicon/clk-hip04.c
>  create mode 100644 include/dt-bindings/clock/hip04-clock.h
> 
> Best Regards
> Haojian
