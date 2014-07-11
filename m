From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 11 Jul 2014 20:16:43 +0400
Subject: =?UTF-8?B?UmU6IGdwaW8tbXhjIGdwaW8gZ2V0IGFsd2F5cyByZXR1cm5zIDAgZm9yIG91?=
 =?UTF-8?B?dHB1dHMgZm9yIElNWDY=?=
In-Reply-To: <20140711160238.GD21766@n2100.arm.linux.org.uk>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140711160238.GD21766@n2100.arm.linux.org.uk>
Message-ID: <1405095403.667469987@f367.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fri, 11 Jul 2014 17:02:38 +0100 ?? Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jul 11, 2014 at 08:34:19AM -0700, Tim Harvey wrote:
> > I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
> > for gpio's configured as outputs regardless of if they are outputing
> > high or low.
> 
> There's a different way which this can be solved - set the SION but on
> your GPIOs.  You will then be able to read back the state of the
> output pin.

AFAIK, SION is not affected for pins configured as GPIO.
Please FIX ME if my opinion is wrong.

---
