From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Jun 2013 13:17:02 +0200
Subject: [PATCH 00/03] ARM: 64-bit memory fixes, APE6EVM second memory bank
In-Reply-To: <20130605104427.1720.68752.sendpatchset@w520>
References: <20130605104427.1720.68752.sendpatchset@w520>
Message-ID: <201306051317.02284.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013, Magnus Damm wrote:
> ARM: 64-bit memory fixes, APE6EVM second memory bank
> 
> [PATCH 01/03] ARM: Let arm_add_memory() always use 64-bit arguments
> [PATCH 02/03] ARM: Handle 64-bit memory in case of 32-bit phys_addr_t
> [PATCH 03/03] ARM: shmobile: Add second memory bank to DTS for APE6EVM
> 
> This patch set contains two fixes and one mach-shmobile specific patch
> to add a second memory bank. The fixes attempt to improve the memory bank
> handling in the ARM kernel in case of 64-bit addresses.

Please have a look at this patch that Stepan Moskovchenko posted:

https://patchwork.kernel.org/patch/2639171/

I think we are going to need only one of the two approaches.

	Arnd
