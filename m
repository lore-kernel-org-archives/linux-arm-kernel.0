From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 14:43:21 +0100
Subject: [PATCH 04/11] ARM64: Prepare Actions Semi S900
In-Reply-To: <20170215165528.10052-5-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-5-afaerber@suse.de>
Message-ID: <6175161.4SuqJTY84p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 15, 2017 5:55:21 PM CET Andreas F?rber wrote:
> 
> +config ARCH_OWL
> +       bool "Actions Semi S900 SoC Family"
> +       help
> +         This enables support for the Actions Semiconductor S900 SoC family.
> +
> 

There seem to be a couple of other SoCs in the same family, so
maybe use a more generic name than S900 in the one-line
Kconfig description.

	Arnd
