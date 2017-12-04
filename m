From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 4 Dec 2017 20:39:01 +0100
Subject: [PATCH v2 2/2] ARM: dts: at91: disable the nxp,se97b SMBUS
 timeout on the TSE-850
In-Reply-To: <20171130211740.GA26784@roeck-us.net>
References: <20171127163101.27859-1-peda@axentia.se>
 <20171127163101.27859-3-peda@axentia.se>
 <20171129205311.GA20551@roeck-us.net>
 <20171129205629.GO21126@piout.net>
 <20171130171638.GA17788@roeck-us.net>
 <20171130172606.GZ21126@piout.net>
 <acaea4f3-d273-444a-4df4-e6d1b35c876d@axentia.se>
 <20171130211740.GA26784@roeck-us.net>
Message-ID: <20171204193901.GH21780@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/2017 at 13:17:40 -0800, Guenter Roeck wrote:
> > I think it's a bugfix; it fixes real problems where the application
> > misbehave due to faulty content when reading from an eeprom. I'm
> > expecting to make a new release for the hw in question RSN and these
> > are the only local patches. So, it would be nice if they made it to
> > 4.14.x before my release happens. However, it's not like it's difficult
> > to rebase the patches should that backport not happen or take too long.
> > 
> Good enough for me. I'll send it as a fix for v4.15, with Cc: stable.
> 

I have it in my fixes branch too, I'll send it to arm-soc soon.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
