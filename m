From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 13:45:08 +0000
Subject: [PATCH v2 05/31] arm64: MMU initialisation
In-Reply-To: <1344966752-16102-6-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-6-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151345.08961.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> This patch contains the initialisation of the memory blocks, MMU
> attributes and the memory map. Only five memory types are defined:
> Device nGnRnE (equivalent to Strongly Ordered), Device nGnRE (classic
> Device memory), Device GRE, Normal Non-cacheable and Normal Cacheable.
> Cache policies are supported via the memory attributes register
> (MAIR_EL1) and only affect the Normal Cacheable mappings.

It looks like you've managed to eliminate bootmem as I suggested earlier,
very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
