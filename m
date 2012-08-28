From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Aug 2012 17:27:05 -0700
Subject: [PATCH] ARM: mach-shmobile: Add compilation support for dtbs
 using 'make dtbs'
In-Reply-To: <1346113322-21133-2-git-send-email-horms@verge.net.au>
References: <1346113322-21133-1-git-send-email-horms@verge.net.au>
 <1346113322-21133-2-git-send-email-horms@verge.net.au>
Message-ID: <503C1059.10300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/27/2012 5:22 PM, Simon Horman wrote:
> +dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dts
> +dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dts

Shouldn't these be dtb instead of dts?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
