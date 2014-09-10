From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Sep 2014 09:55:48 -0700
Subject: [GIT PULL][for 3.18] pull request for the clock update of
 Hisilicon HiX5HD2 soc
In-Reply-To: <5410136A.4080701@hisilicon.com>
References: <5410136A.4080701@hisilicon.com>
Message-ID: <20140910165548.19023.46442@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting xuwei (2014-09-10 02:01:30)
> Hi Mike,
> 
> Please help to merge pull request for the clock update of Hisilicon HiX5HD2 soc. 
> 
> Best Regards,
> Wei
> 
> The following changes since commit 5162797e4d77414cd9ac863ca58588c10b8f8f3a:
> 
>   clk: hix5hd2: add complex clk (2014-09-01 16:09:05 +0100)

Small nitpick: it looks like you generated this pull request against
commit 5162797e, but I think you really meant to use v3.17-rc1.

Also this pull request contains the complex clock but it is not listed
in your tag description below.

Finally, I had some concern about the complex clock implementation (I
think it should use the reset framework to control the Ethernet phy) so
let's resolve that in the other thread before I pull this.

Thanks!
Mike

> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-clock-for-3.18
> 
> for you to fetch changes up to b89ffd8e390a9f0812e62c4985b6d3f246669273:
> 
>   clk: hix5hd2: add I2C clocks (2014-09-01 16:09:33 +0100)
> 
> ----------------------------------------------------------------
> Hisilicon HiX5HD2 clock updates for 3.18
> 
> -Add I2C, watchdog and sd clocks
> -Add clock drivers for HiX5HD2 to support sata, usb and ethernet
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
>  drivers/clk/hisilicon/clk-hix5hd2.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++------
>  include/dt-bindings/clock/hix5hd2-clock.h | 18 ++++++++++++++++++
>  2 files changed, 63 insertions(+), 6 deletions(-)
> 
> 
> 
> 
