From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Dec 2011 23:49:54 +0100
Subject: [PATCH v4 2/6] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <1323186229-22054-3-git-send-email-pawel.moll@arm.com>
References: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
 <1323186229-22054-3-git-send-email-pawel.moll@arm.com>
Message-ID: <5087012.8uYbFcxygW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 December 2011 15:43:45 Pawel Moll wrote:
> This patch gets rid of the MMIO_P2V and __MMIO_P2V macros,
> defining constant virtual base for motherboard and tile
> peripherals instead.
> 
> Additionally, in preparation for the new motherboard memory
> map, the motherboard peripherals are using base pointers
> calculated in runtime, instead of compile-time calculated
> values.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de
