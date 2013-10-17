From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 17 Oct 2013 13:28:29 -0500
Subject: [PATCHv6 2/4] ARM: msm: Add support for APQ8074 Dragonboard
In-Reply-To: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
References: <1382034310-31147-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <86B14DE9-F72B-4B4F-AD7F-AA53792435AE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 17, 2013, at 1:25 PM, Rohit Vaswani wrote:

> This patch adds basic board support for APQ8074 Dragonboard
> which belongs to the Snapdragon 800 family.
> For now, just support a basic machine with device tree.
> 
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> ---
> arch/arm/boot/dts/Makefile                     |  3 ++-
> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts |  6 +++++
> arch/arm/boot/dts/qcom-msm8974.dtsi            | 33 ++++++++++++++++++++++++++
> arch/arm/mach-msm/Kconfig                      | 11 ++++++++-
> arch/arm/mach-msm/board-dt.c                   |  9 +++++++
> 5 files changed, 60 insertions(+), 2 deletions(-)
> create mode 100644 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
> create mode 100644 arch/arm/boot/dts/qcom-msm8974.dtsi

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
