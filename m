From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 4 Jun 2012 13:35:05 +0100 (BST)
Subject: v3.5-rc1 ARM PXA possible regression
Message-ID: <1338813305.51031.YahooMailClassic@web29018.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux 3.5.0-rc1 hangs on boot on my hx4700.

Unfortunately it hangs before the kernel initializes the
screen; since I possess no serial cable I cannot see the
kernel messages.

Linux 3.4.0 boots OK.

Before I start bisecting is there an obvious change
between v3.4 and v3.5-rc1 that I could be investigating?
Since the screen is not initialized I suspect - but
cannot prove - that the kernel hangs before the hx4700
platform code is reached.
