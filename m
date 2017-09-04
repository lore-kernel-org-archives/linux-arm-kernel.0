From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 4 Sep 2017 14:00:51 +0530
Subject: [PATCH] ARM: dts: da850-evm: add chosen and SPI alias
In-Reply-To: <1504278444-13265-1-git-send-email-aford173@gmail.com>
References: <1504278444-13265-1-git-send-email-aford173@gmail.com>
Message-ID: <3fe3b2c0-b658-7b32-f5ea-2b41ca3dd19c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 September 2017 08:37 PM, Adam Ford wrote:
> At the request of Sekhar Nori from TI, this is a follow-up to

This can be:

Suggested-by: Sekhar Nori <nsekhar@ti.com>

> pending ("ARM: dts: da850-evm: add serial and ethernet aliases")

Any patch dependency references need to go below the tear line ("---")
so they don't become part of commit text.

> This patch will add the chosen container to point stdout-path to serial2
> and set the alias for spi0 to spi1 since the SPI NOR flash exists on SPI1.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Can you please re-spin with commit message corrected?

Thanks,
Sekhar
