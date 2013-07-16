From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 16 Jul 2013 14:35:48 -0400
Subject: [PATCH RFC v2 12/14] ARM: debug: move keystone debug to generic
 8250 code
In-Reply-To: <E1Uz8NF-00048J-8B@rmk-PC.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8NF-00048J-8B@rmk-PC.arm.linux.org.uk>
Message-ID: <51E59284.7040109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 July 2013 12:45 PM, Russell King wrote:
> Keystone's debugging is just a copy of the old 8250_32 code with a
> different base address.  Incorporate this into the generic 8250
> debug code.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Just tried the series on Keystone EVM and as expected it works.
Thanks for the conversion.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
