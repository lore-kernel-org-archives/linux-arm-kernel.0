From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Feb 2014 10:20:55 -0700
Subject: [PATCH] ARM: tegra: add SPI flash to Venice2 DT
In-Reply-To: <1392761195-20643-1-git-send-email-swarren@wwwdotorg.org>
References: <1392761195-20643-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5304E7F7.1060000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 03:06 PM, Stephen Warren wrote:
> Venice2 contains an SPI Flash chip, which contains the bootloader.
> Add this to the DT, so the kernel can access it.

I've applied this to Tegra's for-3.15/dt branch.
