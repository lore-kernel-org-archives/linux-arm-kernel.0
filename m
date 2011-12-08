From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Dec 2011 23:46:37 +0000
Subject: [patch 1/1] arch/arm/kernel/setup.c: initialize
 arm_dma_zone_size earlier
In-Reply-To: <20111208213131.407903305@rtp-net.org>
References: <20111208213131.407903305@rtp-net.org>
Message-ID: <20111208234637.GM14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 10:31:09PM +0100, Arnaud Patard wrote:
> arm_dma_zone_size is used by arm_bootmem_free() which is called by
> paging_init(). Thus it needs to be set before calling it.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> CC: stable at kernel.org

Don't _actually_ send stuff to the stable team until it's in mainline,
otherwise you'll get a complaint from them.  See
Documentation/stable_kernel_rules.txt.  (I'm leaving the stable cc
there so they know that this has already been said.)

Apart from that the patch looks fine to me.
