From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Mar 2016 20:03:50 -0600
Subject: [PATCH 3/4] ARM: bcm2835: Enable the VC4 graphics driver in the
 defconfig
In-Reply-To: <1459470643-9070-3-git-send-email-eric@anholt.net>
References: <1459470643-9070-1-git-send-email-eric@anholt.net>
 <1459470643-9070-3-git-send-email-eric@anholt.net>
Message-ID: <56FDD706.10102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 06:30 PM, Eric Anholt wrote:
> Combined with the queued DT changes, we now get HDMI and 3D support.

> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig

>   CONFIG_FB_SIMPLE=y

Do we need to disable that too, or does hand-off from simplefb to the 
accelerated driver work fine?
