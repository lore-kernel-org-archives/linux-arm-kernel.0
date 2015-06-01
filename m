From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:55:34 +0200
Subject: [GIT PULL] Broadcom SoC changes for 4.2 (part 2)
In-Reply-To: <1432936501-20453-1-git-send-email-f.fainelli@gmail.com>
References: <1432936501-20453-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <2256694.0KQLO0mjvp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 14:55:01 Florian Fainelli wrote:
> This pull request contains the following changes for Broadcom SoCs:
> 
> - Dan fixes an error path in the BCM63xx SMP code
> 
> - Ray adds the relevant Kconfig selects to enable the Broadcom NAND driver on Cygnus
> 
> - Kevin provides a change to the Broadcom GISB arbiter driver to make it work with
>   MIPS-based big-endian STB SoCs (this was a long-standing change that had dependencies on
>   code in drivers/of/*)
> 
> - Gregory enables the use of GPIOLIB for brcmstb SoCs and bumps the number of GPIOs for
>   these platforms
> 
> 

Pulled into next/soc, thanks!

	Arnd
