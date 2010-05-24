From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 May 2010 00:01:51 +0100
Subject: [PATCH] ARM: S5P6440: Add External Interrupt support
In-Reply-To: <1274687220-871-1-git-send-email-kgene.kim@samsung.com>
References: <1274687220-871-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100524230151.GB27833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 04:47:00PM +0900, Kukjin Kim wrote:
> +#include <asm/hardware/vic.h>

Doesn't seem to use this header.
