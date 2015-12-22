From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 23:09:42 +0100
Subject: [RFC PATCH 5/5] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
Message-ID: <201512222309.42163.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Andre Przywara wrote:
> To prepare for supporting the Allwinner A64 SoC, introduce a config
> option to allow compiling Allwinner (aka. sunxi) specific drivers
> for ARM64.
> This patch just defines the ARCH_SUNXI symbol to allow Allwinner
> specific drivers to be selected during kernel configuration.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
