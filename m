From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Nov 2012 16:16:24 +0000
Subject: [PATCH 1/8] mfd: ab8500-core: Remove unused ab8500-gpio IRQ ranges
In-Reply-To: <1352128236-11554-2-git-send-email-lee.jones@linaro.org>
References: <1352128236-11554-1-git-send-email-lee.jones@linaro.org>
 <1352128236-11554-2-git-send-email-lee.jones@linaro.org>
Message-ID: <201211051616.24257.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012, Lee Jones wrote:
> The IRQ ranges provided in ab8500-core to be passed on to the
> ab8500-gpio driver are not only redundant, but they are also
> causing a warning in the boot log. These IRQ ranges, like any
> other MFD related IRQ resource are passed though MFD core for
> automatic conversion to virtual IRQs; however, MFD core does
> not support IRQ mapping of IRQ ranges. Let's just remove them.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
