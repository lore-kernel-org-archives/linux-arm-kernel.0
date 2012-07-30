From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 12:57:25 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120727020433.GA3347@b20223-02.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <CAMQu2gw32LogXJJa+K5ZjmCZzBNK3FY2wYwZXU8fsftsVzEO2Q@mail.gmail.com>
 <20120720123317.GA32263@S2101-09.ap.freescale.net>
 <CAJOA=zMQKLTumW7Nx68+yxHC5Yk4QyiL2mf1+TSZfVOAtnXDWA@mail.gmail.com>
 <CAMQu2gy4p+rL-sDAsGCnqSn_2eXwSqf---OS0BSXuDoacjd6_g@mail.gmail.com>
 <20120721063811.GA619@S2101-09.ap.freescale.net>
 <20120727020433.GA3347@b20223-02.ap.freescale.net>
Message-ID: <20120730045715.GA31509@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 10:04:34AM +0800, Richard Zhao wrote:
> Are we going to support the case in the future that cores has
> independent freq? If yes, maybe we should have a more common name.
> 
I do not think we should support that with this driver.  That's one of
the reasons I named the driver this way.

-- 
Regards,
Shawn
