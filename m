From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Nov 2010 16:05:46 -0000
Subject: [PATCH v2] ARM: vexpress: add support for multiple core tiles
In-Reply-To: <1289843693-21823-1-git-send-email-will.deacon@arm.com>
References: <1289843693-21823-1-git-send-email-will.deacon@arm.com>
Message-ID: <000901cb8a5f$1f8dbd20$5ea93760$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> The current Versatile Express BSP defines the MACHINE_START macro
> in the core tile code.
> 
> This patch moves this into the generic board code and introduces
> a method for determining the current tile at runtime, allowing
> the Kernel to have support for multiple tiles compiled in.
> Tile-specific functions are executed via a descriptor struct containing
> the correct implementations for the current tile.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---

[...]

Do you have any feedback on this patch or can I submit it to the patch
system please?

Thanks,

Will
