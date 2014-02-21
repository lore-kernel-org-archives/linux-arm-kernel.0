From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Feb 2014 21:53:56 -0700
Subject: [PATCH] ARM: bcm2835: Move to mach-bcm directory
In-Reply-To: <1392941771-15774-1-git-send-email-markus.mayer@linaro.org>
References: <1392941771-15774-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <5306DBE4.8090106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 05:16 PM, Markus Mayer wrote:
> Move the bcm2835 board file into the mach-bcm directory. This allows us
> to get rid of the mach-bcm2835 directory with the associated Kconfig
> and Makefile.

This looks fine, although it needs a small patch to bcm2835_defconfig
squashed in, which I'll post in a second.

Do you want me to take it through the bcm2835 tree? That's probably
easiest to avoid conflicts with any other bcm2835 patches, not that it's
too likely there will be any to the board file.
