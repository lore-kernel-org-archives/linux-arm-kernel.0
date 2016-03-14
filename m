From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Mar 2016 09:09:45 -0700
Subject: Regression in next caused by 95026658c46e i2c: do not use internal..
Message-ID: <20160314160944.GG9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudip & Wolfram,

Looks like commit 95026658c46e ("i2c: do not use internal data from
driver core") in Linux next introduced a regression breaking booting
on most ARM boards according to kernelci.org [0].

Having something like this happen just as the merge window opens is
not nice. You guys should already know.. The patches in next should
be sitting there for a few weeks before the merge window so issues
like this are found out early.

Regards,

Tony

[0] https://kernelci.org/boot/all/job/next/
