From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Apr 2015 22:38:33 -0600
Subject: [PATCH 8/9] ARM: Add MAINTAINERS for 2836.
In-Reply-To: <1429639796-2169-9-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-9-git-send-email-eric@anholt.net>
Message-ID: <5539C8C9.1010705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 12:09 PM, Eric Anholt wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS

> +BROADCOM BCM2836 ARM ARCHITECTURE
> +M:	Eric Anholt <eric@anholt.net>
> +L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
> +S:	Maintained
> +N:	bcm2836

I'm tempted to suggest just adding this to the existing bcm2835 entry,
since they're almost the same SoC.
