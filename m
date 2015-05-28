From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 28 May 2015 09:48:16 -0700
Subject: [PATCH v5 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
 (Bintian Wang's message of "Thu, 7 May 2015 22:00:19 +0800")
References: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <7hy4k8k5rj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bintian Wang <bintian.wang@huawei.com> writes:

> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, clock driver, device tree
> configuration.
>
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI 

Tested-by: Kevin Hilman <khilman@linaro.org>

I've now tested this version on top of v4.1-rc5 using the mainline
u-boot port[1], and confirm that all 8 cores are booting.

No UEFI required... yay!

Kevin

[1] http://lists.denx.de/pipermail/u-boot/2015-May/214006.html
