From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Sep 2011 19:54:32 +0100
Subject: [PATCH v2 0/7] Add a generic struct clk
In-Reply-To: <1316730422-20027-1-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
Message-ID: <20110929185432.GD2085@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:26:55PM -0700, Mike Turquette wrote:

> more thought.  I also dropped Mark's change to append a device's name to
> a clk name since device tree might solve this neatly.  Again more
> discussion around that would be good.

Some of that was for debugfs type stuff - if we end up providing
information about the clocks via a diagnostic interface being able to
distinguish between things in a textual fashion would be handy (and I'd
guess the struct device may also be needed by any OF bindings to get at
the bindings?).
