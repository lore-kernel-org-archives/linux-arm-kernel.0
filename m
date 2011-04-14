From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 11:14:53 +0100
Subject: [PATCH] ARM: Remove clkdev.o build in arch/arm/common/Makefile
In-Reply-To: <1302775761-27139-1-git-send-email-thomas.ab@samsung.com>
References: <1302775761-27139-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20110414101453.GD1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 03:39:21PM +0530, Thomas Abraham wrote:
> clkdev.c is moved to drivers/clk. So build for clkdev.o can
> be removed from arch/arm/common/Makefile.

See my fixes branch.
