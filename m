From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Mon, 28 Sep 2009 09:53:44 +0300
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
In-Reply-To: <19134.28977.5491.323804@pilspetsen.it.uu.se>
References: <19134.28977.5491.323804@pilspetsen.it.uu.se>
Message-ID: <4AC05D78.20007@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Mikael Pettersson wrote:
> +config N2100_XINT1_UART
> +	bool "Support assigning Thecus n2100 XINT1 to UART"
> +	depends on MACH_N2100 && NO_HZ

This shouldn't depend on NO_HZ. Some people may want to use it
just to get (much) faster serial console.

A.
