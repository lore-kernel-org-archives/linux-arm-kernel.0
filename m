From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Jan 2013 14:46:29 +0000
Subject: [PATCH v3 0/7] arm64: ARMv8 RTSM model SoC support
In-Reply-To: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
References: <1357309041-6192-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <201301041446.29443.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 January 2013, Catalin Marinas wrote:
> That's the third version of the patch series adding support for the
> ARMv8 RTSM model (vexpress-like) to the AArch64 kernel. There is no
> SoC-specific code under arch/arm64/ as the kernel makes use of the
> vexpress support already under drivers/ (apart from dts, defconfig and
> some Kconfig changes).


Whole series:

Acked-by: Arnd Bergmann <arnd@arndb.de>
