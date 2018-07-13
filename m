From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Fri, 13 Jul 2018 12:56:01 +0300
Subject: [PATCH 2/3] mtd: atmel nand: fix build warning on 64-bit
In-Reply-To: <20180709155730.2422841-2-arnd@arndb.de>
References: <20180709155730.2422841-1-arnd@arndb.de>
 <20180709155730.2422841-2-arnd@arndb.de>
Message-ID: <0b4ee469-8c37-9002-9067-f37f8dde869e@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd,

On 07/09/2018 06:57 PM, Arnd Bergmann wrote:
> +	nc->ebi_csa_offs = (uintptr_t)match->data;

I guess we should declare ebi_csa_offs as size_t, right?

Best,
ta
