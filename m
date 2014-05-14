From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 May 2014 09:57:23 -0600
Subject: [PATCH v2] ARM: tegra: enable joystick in tegra_defconfig
In-Reply-To: <1400033353-25673-1-git-send-email-acourbot@nvidia.com>
References: <1400033353-25673-1-git-send-email-acourbot@nvidia.com>
Message-ID: <53739263.6080706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 08:09 PM, Alexandre Courbot wrote:
> NVIDIA SHIELD embeds a USB joystick device. Enable the corresponding
> support in tegra_defconfig.

I've squashed this into Tegra's for-3.16/defconfig branch.
