From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Feb 2014 19:49:39 -0700
Subject: [PATCH] ARM: bcm2835: fix defconfig to select ARCH_BCM
In-Reply-To: <1392958593-11910-1-git-send-email-swarren@wwwdotorg.org>
References: <1392958593-11910-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <530C04C3.9000305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 09:56 PM, Stephen Warren wrote:
> Without this, ARCH_BCM2835 is no longer available, and hence the kernel
> won't boot!

I've squashed this into bcm2835's for-3.15/soc branch.
