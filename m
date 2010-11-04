From: awg@embtoolkit.org (Abdoulaye Walsimou GAYE)
Date: Thu, 04 Nov 2010 10:53:43 +0100
Subject: [PATCH] arm: Fix HAVE_S3C2410_WATCHDOG warnings
In-Reply-To: <20101104081633.GA27129@july>
References: <20101104081633.GA27129@july>
Message-ID: <4CD282A7.9080204@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2010 09:16 AM, Kyungmin Park wrote:
> Fix build warnings
> warning: (ARCH_S3C64XX && <choice> && WATCHDOG || ARCH_S5P64X0 && <choice> && WATCHDOG || ARCH_S5P6442 && <choice> && WATCHDOG || ARCH_S5PC100 && <choice> || ARCH_S5PV210 && <choice> || ARCH_S5PV310 && <choice> || MACH_SMDK6410 && ARCH_S3C64XX) selects HAVE_S3C2410_WATCHDOG which has unmet direct dependencies (WATCHDOG)
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   
Kyungmin Park,
The same warning appears when I2C is not selected.

Best regards,
AWG
