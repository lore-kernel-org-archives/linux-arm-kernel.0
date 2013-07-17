From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Jul 2013 10:26:47 +0100
Subject: [PATCH RFC v2 08/14] ARM: debug: provide PL01x debug uart
 phys/virt address configuration options
In-Reply-To: <E1Uz8JM-00047w-PP@rmk-PC.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8JM-00047w-PP@rmk-PC.arm.linux.org.uk>
Message-ID: <1374053207.3146.90.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-16 at 17:41 +0100, Russell King wrote:
> Move the definition of the UART register addresses out of the platform
> specific header files into the Kconfig files.
> 
> Acked-by: Ryan Mallon <rmallon@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For the vexpress parts:

Acked-by: Pawel Moll <pawel.moll@arm.com>
