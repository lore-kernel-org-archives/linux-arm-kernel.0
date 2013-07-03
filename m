From: mindentropy@gmail.com (mind entropy)
Date: Wed, 3 Jul 2013 19:05:03 +0530
Subject: On common struct clk in clock framework.
Message-ID: <CAM2a4uyrX0t-W8hXKROvZgJPSyCY+DaviV-eRVZOhyPx=WNBUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

   I am reading through mini2440 code and trying to understand
clocking code. I am getting confused as to whether it uses the common
clocking framework. In
https://github.com/torvalds/linux/blob/master/arch/arm/plat-samsung/include/plat/clock.h#L42
they define a struct clk. Even in OMAP
(http://processors.wiki.ti.com/index.php/Clock_Framework_User_Guide#Software_Implementation)
they have a separate struct clk definition. In the common clocking
framework shouldn't they be using the common struct clk rather than
have their own versions of struct clk?

Thanks in advance.
