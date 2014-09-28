From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 28 Sep 2014 10:51:50 -0700
Subject: [GIT PULL v2][for 3.18] pull request for the clock update of
 Hisilicon HiX5HD2 soc
In-Reply-To: <54277F20.5090604@hisilicon.com>
References: <54277F20.5090604@hisilicon.com>
Message-ID: <20140928175150.19023.99961@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Wei Xu (2014-09-27 20:23:12)
> Hi Mike,
> 
> Please help to merge pull request for the clock update of Hisilicon HiX5HD2 soc. 
> 
> Best Regards,
> Wei
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-clock-for-3.18-v2

Pulled!

Thanks,
Mike

> 
> for you to fetch changes up to 45bcf9c6f299ae77c14c2ae8cea3f8e540fe80d1:
> 
>   clk: hix5hd2: add I2C clocks (2014-09-28 10:27:09 +0800)
> 
> ----------------------------------------------------------------
> Hisilicon HiX5HD2 clock updates for 3.18-v2
> 
> - Add I2C clocks
> - Add watchdog clocks
> - Add sd clocks
> - Add complex clock implementation to support sata, usb and ethernet
> 
> ----------------------------------------------------------------
> Guoxiong Yan (1):
>       clk: hix5hd2: add watchdog0 clocks
> 
> Jiancheng Xue (1):
>       clk: hix5hd2: add sd clk
> 
> Wei Yan (1):
>       clk: hix5hd2: add I2C clocks
> 
> Zhangfei Gao (1):
>       clk: hix5hd2: add complex clk
> 
>  drivers/clk/hisilicon/clk-hix5hd2.c       | 232 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  include/dt-bindings/clock/hix5hd2-clock.h |  27 +++++++++++++++++++
>  2 files changed, 253 insertions(+), 6 deletions(-)
> 
