From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Mar 2014 10:00:43 -0700
Subject: [PATCH] ARM: tegra: add device tree for SHIELD
In-Reply-To: <1393818596-26775-1-git-send-email-acourbot@nvidia.com>
References: <1393818596-26775-1-git-send-email-acourbot@nvidia.com>
Message-ID: <5314B53B.4010107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2014 08:49 PM, Alexandre Courbot wrote:
> Add a device tree for NVIDIA SHIELD. The set of enabled features is
> still minimal with no display option and USB requiring external power.
> 
> A default kernel command-line as well as initrd addresses are hardcoded
> to match the static values the bootloader is known to use. This allows
> booting from an appended DTB without having to alter it at boot time,
> since the bootloader has no Device Tree support.

This and the TN7 patch look fine. Hopefully I'll apply them soon,
pending the ti,irq-externally-inverted discussion.

> +	/* SD card */

Oh, that's all you meant by wanting to add comments? I guess I just
recognize SD-vs-eMMC by the bus width, but adding the comments is a good
idea.
