From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 30 Aug 2011 20:23:21 -0400 (EDT)
Subject: [GIT PULL] msm: devboard defconfigs
In-Reply-To: <20110830225213.GB7093@huya.qualcomm.com>
References: <20110830225213.GB7093@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1108302021530.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2011, David Brown wrote:

> Unless Russell objects, and prefers these to be in his tree, I'm fine
> with having these in a branch for linux-next that isn't merged
> upstream for now.
> 
> The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:
> 
>   Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
> 
> are available in the git repository at:
>   git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-defconfig
> 
> David Brown (1):
>       ARM: msm: defconfigs for Qualcomm dev boards
> 
>  arch/arm/configs/msm7x30_defconfig |   68 +++++++++
>  arch/arm/configs/msm8660_defconfig |   96 +++++++++++++
>  arch/arm/configs/msm8960_defconfig |  265 ++++++++++++++++++++++++++++++++++++
>  arch/arm/configs/qsd8x50_defconfig |   82 +++++++++++

What prevents you from merging them together?
Can't you build a single kernel binary with support for allMSM targets?


Nicolas
