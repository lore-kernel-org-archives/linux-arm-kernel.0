From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jul 2011 10:31:24 +0100
Subject: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
In-Reply-To: <20110711025344.GA27497@opensource.wolfsonmicro.com>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
Message-ID: <20110711093124.GA3239@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
> The biggest issue I ran into was that as the clocks are all registered
> by name with the API if you've got two instances of the same off-SoC
> device in the system you'll not be able to disambiguate between the
> clocks it provides.

Sigh.  That sounds like yet more trash.  Obviously whoever thought
up that doesn't actually understand clks.
