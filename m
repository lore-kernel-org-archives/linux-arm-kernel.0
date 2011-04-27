From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 10:33:28 +0100
Subject: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
In-Reply-To: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
Message-ID: <20110427093328.GU17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 01:13:28PM -0700, Philip Rakity wrote:
> The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
> clock.  This feature is useful and required depending on the board
> design.  Add infrastructure to support SD clock tuning.

It just adds fields to a structure which remain unused.  On its own this
patch is useless, and I don't see a patch which makes use of these new
fields in any way.  Did you forget to copy it to the linux-arm-kernel
list?
