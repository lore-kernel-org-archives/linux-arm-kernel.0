From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jan 2011 11:00:29 +0000
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <20110110104122.GI12078@pengutronix.de>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
	<20110108131520.GE26617@pengutronix.de>
	<201101101043.05406.jeremy.kerr@canonical.com>
	<20110110104122.GI12078@pengutronix.de>
Message-ID: <20110110110028.GB12552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 11:41:22AM +0100, Sascha Hauer wrote:
> This branch must be reworked because the correct locking is missing, but
> the first branch should be ready for merging once your clk-common
> patches are merged. I'll post the patches for review soon. I hope it's
> clear soon that your clk-common patches get merged.

Unless the locking problems can be resolved, the patches aren't ready.
