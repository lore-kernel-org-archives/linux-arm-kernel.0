From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2011 15:27:41 +0000
Subject: [PATCH v2 1/9] lpc2k: Core support
In-Reply-To: <1300461116-6028-2-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-2-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <20110318152741.GP29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 04:11:48PM +0100, Ithamar R. Adema wrote:
> +config ARCH_LPC2K
> +	bool "NXP LPC2K Family"
> +	depends on !MMU
> +	select CPU_ARM7TDMI
> +	select ARM_VIC
> +	select GENERIC_TIME

GENERIC_TIME no longer exists as a valid configuration symbol, so please
remove this.
