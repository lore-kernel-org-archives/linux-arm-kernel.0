From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 May 2014 09:57:46 -0600
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
In-Reply-To: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
References: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
Message-ID: <536A57FA.2090608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 09:18 PM, Alexandre Courbot wrote:
> Console rotation is needed for devices like Tegra Note 7 and NVIDIA
> SHIELD to get the boot console in the expected orientation.

I've squashed this into Tegra's for-3.16/defconfig branch.

Can you please also update multi_v7_defconfig, and send that change to
arm-soc (arm at kernel.org) to be applied. Thanks.
