From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 2 Aug 2014 08:45:19 -0700
Subject: [PATCH v2 1/6] wdt: sunxi: Move restart code to the watchdog
 driver
In-Reply-To: <20140802080208.GA22804@spo001.leaseweb.com>
References: <1399430664-29091-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140507213318.GA2105@roeck-us.net>
 <20140515091123.GQ29258@lukather> <20140519150422.GA27329@lukather>
 <20140522203444.GE27329@lukather>
 <20140522211207.GA28704@roeck-us.net>
 <20140623103142.GB19730@lukather>
 <20140623211323.GA28120@spo001.leaseweb.com>
 <20140624144954.GP19730@lukather>
 <20140802080208.GA22804@spo001.leaseweb.com>
Message-ID: <20140802154519.GA21259@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 10:02:08AM +0200, Wim Van Sebroeck wrote:
> Maxime, All,
> 
> > > 1) For me the discussion was not ended and needs further
> > > thinking. (And I just read some good ideas about it).
> > 
> > It would have been great for you to mention it then.
> > 
> > > 2) You never mentioned you needed this in for 3.16 and that things
> > > would break because of it.
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/257690.html
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259109.html
> > 
> > I thought it was pretty clear.
> > 
> 
> I will put it in now as step in between before going over to the new restart system.
> Anyone objections?
> 
Ok with me.

Guenter
