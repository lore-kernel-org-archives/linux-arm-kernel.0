From: briannorris@chromium.org (Brian Norris)
Date: Mon, 25 Apr 2016 16:24:51 -0700
Subject: [PATCH RESEND v2 2/4] ARM64: dts: rockchip: add core dtsi file
 for RK3399 SoCs
In-Reply-To: <1461304307-14113-3-git-send-email-jay.xu@rock-chips.com>
References: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
 <1461304307-14113-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20160425232451.GB59576@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 01:51:45PM +0800, Jianqun Xu wrote:
> This patch adds core dtsi file for Rockchip RK3399 SoCs.
> 
> The RK3399 has big/little architecture, which needs a separate
> node for the PMU of each microarchitecture, for now it missing
> the pmu node since the old one could not work well.
> 
> Marc is working on it with:
> https://lkml.org/lkml/2016/4/11/182
> 
> and on the following branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> irq/percpu-partition
> 
> That will to be tested on RK3399 evb.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> changes in v2:
> - remove arm-pmu at first. (Marc, Heiko, Mark)
> - remove rga, emmc, usb3, mipi, edp, pd, i2c, gpu, thermal, tsadc, saradc, which will upstream independently

Tested (a non EVB board) and can boot to prompt:

Tested-by: Brian Norris <briannorris@chromium.org>
