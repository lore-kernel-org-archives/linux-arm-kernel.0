From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 10:08:03 +0000
Subject: [PATCH 01/16] ARM: LPC32XX: clock lookups array should not be
	tagged __initdata
In-Reply-To: <1265155168-28909-2-git-send-email-wellsk40@gmail.com>
References: <1265155168-28909-2-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203100803.GA22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 03:59:13PM -0800, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> struct clk looksup[] should not be tagged with the __initdata
> attribute so system functions after bootup can use the clkdev
> support.

Can you roll this into your previous patch set please?
