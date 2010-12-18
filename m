From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 08:27:03 +0000
Subject: [PATCH 2/6] OMAP4: Pandaboard: Add omap_reserve functionality
In-Reply-To: <20101218030521.10251.89993.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
	<20101218030521.10251.89993.stgit@baageli.muru.com>
Message-ID: <20101218082703.GB3047@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 07:05:21PM -0800, Tony Lindgren wrote:
>  	/* Maintainer: David Anders - Texas Instruments Inc */
>  	.boot_params	= 0x80000100,
>  	.map_io		= omap4_panda_map_io,
> +	.reserve	= omap_reserve,

Please put .reserve before .map_io.
