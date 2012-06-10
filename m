From: michael@walle.cc (Michael Walle)
Date: Sun, 10 Jun 2012 23:22:01 +0200
Subject: [PATCH 9/9] Kirkwood: Add basic device tree support for QNAP
 TS219.
In-Reply-To: <1339324322-29388-10-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-10-git-send-email-andrew@lunn.ch>
Message-ID: <201206102322.01981.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 10 Juni 2012, 12:32:01 schrieb Andrew Lunn:

[..]

> +config MACH_TS219_DT
> +	bool "Device Tree for QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219,
> TS-219P and TS-219P+ Turbo NAS" +	select ARCH_KIRKWOOD_DT
> +	select ARM_APPENDED_DTB
> +	select ARM_ATAG_DTB_COMPAT
> +	help
> +	  Say 'Y' here if you want your kernel to support the QNAP
> +  	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
> +  	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
> +  	  There are two different Device Tree descriptions, depending
> +  	  on if the device is based on an if the board uses the MV6281
> +  	  or MV6282. If you have the wrong one, the buttons will not
> +  	  work.
> +

whitespace errors above


-- 
Michael
