From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 3 Jan 2013 22:00:36 +0100
Subject: [PATCH 0/9] ARM: Initial support for Tegra 114 SoC.
In-Reply-To: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130103210036.GA4412@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 11:43:58AM +0200, Hiroshi Doyu wrote:
> Hi,
> 
> This patchset adds initial support for the NVIDIA's new Tegra 114
> SoC (T114) based on the ARM Cortex-A15 MP. It has the minimal support
> to allow the kernel to boot up into shell console. This can be used as
> a basis for adding other device drivers for this SoC. Currently there
> are 2 evaluation boards available, "Dalmore" and "Pluto".
> 
> This patchset is against Stephen Warren's linux-next_common branch:
> 
>   git://nv-tegra.nvidia.com/user/swarren/linux-2.6 linux-next_common
> 
> For those who want to try:
> 
>   $ make ARCH=arm tegra_defconfig
>   $ scripts/config -e ARCH_TEGRA_114_SOC -d DRM -d SUSPEND \
>     	-d PM_RUNTIME -d CPU_FREQ -d CPU_IDLE

I wonder, what's the reason for disabling DRM? And while on the topic,
are there any plans to release a Tegra114 TRM?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/3c2ce37d/attachment.sig>
