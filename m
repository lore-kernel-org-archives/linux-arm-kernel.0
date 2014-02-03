From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Feb 2014 16:32:25 +0100
Subject: [PATCH 09/10] watchdog: xilinx: Add missing binding
In-Reply-To: <24ecacca-2714-4834-921c-b827c0e592a3@VA3EHSMHS003.ehs.local>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <201402031606.11753.arnd@arndb.de>
 <24ecacca-2714-4834-921c-b827c0e592a3@VA3EHSMHS003.ehs.local>
Message-ID: <3121595.GbLMuGPlvA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 February 2014 16:13:47 Michal Simek wrote:
> Intention wasn't to fix binding but document current one
> which is in mainline for a long time.

Ok, I see.

> Apart of this - yes, wdt-enable-once is nowayout and wdt-interval should be timeout
> is seconds, and clock-frequency should go out and use CCF for getting clock.

Could we make a common binding then, and document that the xilinx
watchdog can optionally provide either one?

	Arnd
