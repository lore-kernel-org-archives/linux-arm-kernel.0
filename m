From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Jun 2010 09:05:56 +0800
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <4C1FCEDA.3000303@bluewatersys.com>
References: <1277098513.947920.264679354891.2.gpush@pororo>
	<4C1FCEDA.3000303@bluewatersys.com>
Message-ID: <201006220905.57533.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

> Not sure if this has been discussed already, but shouldn't rate be const
> for a fixed clock?

No, we may need to set the rate at some point - eg, when setting up the 
clocks, or parsing from the device tree.

Cheers,


Jeremy
