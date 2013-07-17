From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Jul 2013 17:35:19 +0530
Subject: [PATCH RFC v2 13/14] ARM: debug: move davinci debug to generic
 8250 code
In-Reply-To: <E1Uz8OD-00048N-Be@rmk-PC.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8OD-00048N-Be@rmk-PC.arm.linux.org.uk>
Message-ID: <51E6887F.3090808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/16/2013 10:16 PM, Russell King wrote:
> Davinci's debugging is just a copy of the old 8250_32 code with a
> different base address.  Incorporate this into the generic 8250
> debug code.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested on DA850 EVM

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
