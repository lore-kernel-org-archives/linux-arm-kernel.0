From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 14:32:30 -0500 (EST)
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <alpine.LFD.2.02.1301101430200.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Shawn Guo wrote:

> All the arch_decomp_wdog related codes are there without any users,
> since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which however
> is not used by arch/arm/boot/compressed/decompress.c.

It is also worth mentioning that CONFIG_S3C_BOOT_WATCHDOG is not set 
anywhere.

For those 3 patches:

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
