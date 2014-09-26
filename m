From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 26 Sep 2014 16:32:10 -0700
Subject: [PATCH v5 0/4] clk: hix5hd2: clocks update
In-Reply-To: <1411356016-20553-1-git-send-email-zhangfei.gao@linaro.org>
References: <1411356016-20553-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140926233210.19023.98858@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Zhangfei Gao (2014-09-21 20:20:12)
> v5:
> 0001:
> Suggested by Mike, change to clk_ether_prepare since delay required inside
> 
> v4:
> Drop ir clock, whose register is not in the same region
> 
> v3: 
> Add patches 3, 4, 5 for clocks of watchdog, ir, and i2c
> Patches 1, 2 are same as v2

Patches look OK to me. Will you or Wei be sending me a pull request?

Also in the future please try to have more info in your change logs.

Regards,
Mike

> 
> Guoxiong Yan (1):
>   clk: hix5hd2: add watchdog0 clocks
> 
> Jiancheng Xue (1):
>   clk: hix5hd2: add sd clk
> 
> Wei Yan (1):
>   clk: hix5hd2: add I2C clocks
> 
> Zhangfei Gao (1):
>   clk: hix5hd2: add complex clk
> 
>  drivers/clk/hisilicon/clk-hix5hd2.c       |  236 ++++++++++++++++++++++++++++-
>  include/dt-bindings/clock/hix5hd2-clock.h |   27 ++++
>  2 files changed, 257 insertions(+), 6 deletions(-)
> 
> -- 
> 1.7.9.5
> 
