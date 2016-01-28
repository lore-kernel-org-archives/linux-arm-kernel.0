From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 28 Jan 2016 11:57:40 +0000
Subject: Tegra baseline test results for v4.5-rc1
In-Reply-To: <56AA0174.5030608@nvidia.com>
References: <56AA0174.5030608@nvidia.com>
Message-ID: <56AA0234.7010903@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/01/16 11:54, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.5-rc1.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.5-rc1/20160128033104/
> 
> 
> Test summary
> ------------
> 
> Build: zImage:
>     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig
> 
> Build: Image:
>     Pass: ( 1/ 1): defconfig
> 
> Boot to userspace: defconfig:
>     FAIL: ( 1/ 2): qemu-vexpress64

This is a known issue [0] and a fix is in the works [1].

Jon

[0] https://lkml.org/lkml/2015/12/23/462
[1] http://marc.info/?l=linux-arm-kernel&m=145269663127115&w=2
