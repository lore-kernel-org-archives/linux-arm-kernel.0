From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 May 2015 21:45:21 +0800
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <CAD6h2NTJMTuPxX097js3JvpweJqYm=js_27Q9ZijMH0i2jaAhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 20:06, Bintian Wang <bintian.wang@huawei.com> wrote:
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
>
> Changes v4:
> * Rebase to kernel 4.1-rc1
> * Delete "arm,cortex-a15-gic" from the gic node in dts
>

Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
