From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 May 2014 10:32:20 -0600
Subject: [PATCH 1/2] ARM: tegra: joystick input in tegra_defconfig
In-Reply-To: <1399883209-31169-2-git-send-email-acourbot@nvidia.com>
References: <1399883209-31169-1-git-send-email-acourbot@nvidia.com>
 <1399883209-31169-2-git-send-email-acourbot@nvidia.com>
Message-ID: <5370F794.2020800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2014 02:26 AM, Alexandre Courbot wrote:
> NVIDIA SHIELD embeds a USB controller. Compile the corresponding support

USB controller or USB joystick?

> as a module in tegra_defconfig.

Why make this a module rather than built-in. Almost everything else in
tegra_defconfig is built-in, except brcmfmac since it doesn't handle
lack of firmware availability at probe time.
