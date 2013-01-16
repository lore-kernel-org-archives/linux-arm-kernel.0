From: marex@denx.de (Marek Vasut)
Date: Wed, 16 Jan 2013 19:46:32 +0100
Subject: [RFC PATCH 0/5] Reset controller API to reset IP modules on i.MX5
 and i.MX6
In-Reply-To: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <201301161946.32926.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Philipp Zabel,

> The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> 
> The following patches add a simple API for devices to request being reset
> by separate reset controller hardware. They implement the reset signal
> device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
> the i.MX SRC has self-deasserting reset bits, so I've included both
> ops to manually assert/deassert a reset line, as well as a reset
> operation that is supposed to assert the reset line and wait for it to
> deassert.
> 
> The i.MX SRC is enhanced to provide a reset controller and the IPU driver
> is made to request being reset by calling the device_reset(&pdev->dev)
> convenience wrapper during probing.
> 
> regards
> Philipp

I won't be able to test it before 23rd this month. Sorry!

Best regards,
Marek Vasut
