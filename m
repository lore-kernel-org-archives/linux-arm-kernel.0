From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 26 Feb 2015 16:10:15 -0600
Subject: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
In-Reply-To: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <24986C4E-2DED-456F-A1D3-E52037540E01@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 25, 2015, at 4:54 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> Hi,
> 
> These patches used to be part of my cpuidle patchset, think these can go in
> independently.
> 
> The patches do the following -
> 
> 1. Add QCOM Secure Monitor specific enumeration for warm boot on qcom targets
> 2. Add an API to set up the warmboot address. Consolidate the warm boot flags
> into the implementation file 
> 
> Thanks,
> Lina
> 
> Lina Iyer (2):
>  ARM: qcom: Add SCM warmboot flags for quad core targets.
>  qcom: scm: Add scm_set_warm_boot_addr function
> 
> arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
> arch/arm/mach-qcom/scm-boot.h |  5 +++--
> 2 files changed, 41 insertions(+), 2 deletions(-)

Lina,

Do you mind rebasing these patches on my recent SCM cleanup set.  You find it at:

git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git qcom/scm-cleanup

thanks

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
