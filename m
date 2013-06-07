From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 12:53:13 +0200
Subject: [PATCH] cpuidle: move ARCH_NEEDS_CPU_IDLE_COUPLED Kconfig option
In-Reply-To: <51AF3424.5060200@linaro.org>
References: <1460854.rT4b7LefMM@wuerfel> <51AF3424.5060200@linaro.org>
Message-ID: <7104482.Ecl7mMk8ke@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013 14:50:44 Daniel Lezcano wrote:
> 
> IMHO, this option depends on CPU_IDLE and thus must be kept inside the
> CPU_IDLE menuconfig.
> 
> The warning raised here is because this option is selected by the arch
> Kconfig without checking if CPU_IDLE is set or not.
> 
> I am in favor to change the OMAP / TEGRA Kconfigs instead, in this way:

Fine with me as well.

	Arnd
