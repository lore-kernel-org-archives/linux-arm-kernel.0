From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Feb 2014 19:49:24 -0700
Subject: [PATCH] ARM: bcm2835: Move to mach-bcm directory
In-Reply-To: <1392941771-15774-1-git-send-email-markus.mayer@linaro.org>
References: <1392941771-15774-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <530C04B4.9020204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 05:16 PM, Markus Mayer wrote:
> Move the bcm2835 board file into the mach-bcm directory. This allows us
> to get rid of the mach-bcm2835 directory with the associated Kconfig
> and Makefile.

I've applied this to bcm2835's for-3.15/soc branch (and squashed the
defconfig fix into it).
