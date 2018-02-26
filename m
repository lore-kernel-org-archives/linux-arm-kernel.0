From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 26 Feb 2018 12:03:16 +0530
Subject: [PATCH V2] ARM: dts: da850-evm: add chosen and SPI alias
In-Reply-To: <1504563124-25568-1-git-send-email-aford173@gmail.com>
References: <1504563124-25568-1-git-send-email-aford173@gmail.com>
Message-ID: <27fcbdce-8038-f288-1aa5-0744d2abdba5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 September 2017 03:42 AM, Adam Ford wrote:
> This patch will add the chosen container to point stdout-path to serial2
> and set the alias for spi0 to spi1 since the SPI NOR flash exists on SPI1.
> 
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Looks like this patch just never got applied. Sorry about that. Applied
to v4.17/dt now.

Thanks,
Sekhar
