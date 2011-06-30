From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 30 Jun 2011 15:13:09 +0530
Subject: [PATCH 3/7] ARM: SAMSUNG: Add SPI clock definitions for SAMSUNG
	SoCs
In-Reply-To: <20110630093024.GT21898@n2100.arm.linux.org.uk>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
	<1309436723-662-4-git-send-email-padma.v@samsung.com>
	<20110630093024.GT21898@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=u7hrqZwo2kCp-iNgnwWUcw_uBog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 3:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 30, 2011 at 08:25:19AM -0400, Padmavathi Venna wrote:
>> SPI Clocks were defined in dev-spi.c of machine specific folder.
>> To make SPI devices common across all SoCs,dev-spi.c is moved
>> from machine specific folder to plat-samsung. So SPI clock
>> definitions has been moved from dev-spi.c to SoC specific machine
>> folder for S3C64XX,S5P64X0,S5PC100 and S5PV210
>
> This just shows how sick the Samsung code is by abusing the clk API.
> If it stopped that abuse and switched over to clkdev none of this would
> be necessary.
I am anyways not for the patch set.
Though this 'sickness' predates clkdev, and I agree it should be changed now.
