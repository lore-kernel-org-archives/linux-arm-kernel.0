From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Jun 2013 16:02:34 -0700
Subject: [PATCH v3 5/7] clk: add basic Rockchip rk3066a clock support
In-Reply-To: <201306130045.41723.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
 <201306111331.31517.heiko@sntech.de>
 <20130611200610.8816.68285@quantum>
 <201306130045.41723.heiko@sntech.de>
Message-ID: <20130612230234.GB9016@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 12:45:41AM +0200, Heiko St?bner wrote:
> Part of me simply wants to wait for this - but rockchip stuff might be to late 
> for 3.11 anyway, as we're near rc6.

For a new platform like this, it's useful to get some of the drivers to land
even if the main platform code isn't. Where things tend to get messy is when we
have to add a lot of code late in the cycle that has a lot of external
dependencies, since everybody then has to scramble about getting things sorted
out.

It's not too late for 3.11 yet, and in particular it'd be nice to see things
like clock and pinctrl stuff go in even if some other stuff misses the train.


-Olof
