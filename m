From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 23 Feb 2014 18:34:17 +0100
Subject: [PATCH 3/4] ARM: mvebu: Add HP T5325 thin client
In-Reply-To: <1393175982-18516-4-git-send-email-andrew@lunn.ch>
References: <1393175982-18516-1-git-send-email-andrew@lunn.ch>
 <1393175982-18516-4-git-send-email-andrew@lunn.ch>
Message-ID: <20140223183417.306e17e6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

Sorry, I'm in a nitpick mood it seems :)

On Sun, 23 Feb 2014 18:19:41 +0100, Andrew Lunn wrote:

> +		button at 1 {
> +			label = "Power Button";
> +			linux,code = < KEY_POWER >;

Why spaces before and after KEY_POWER ?

> +config MACH_T5325
> +	bool "HP T5325 thin client"
> +	depends on MACH_KIRKWOOD
> +	help
> +	 Say 'Y' here if you want your kernel to support the
> +	 HP T5325 Thin client

Indentation for help text should be one tab and two spaces.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
