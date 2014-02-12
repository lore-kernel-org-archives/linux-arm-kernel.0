From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 12 Feb 2014 08:41:34 -0800
Subject: [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device
 registration
In-Reply-To: <1392206196.848.18.camel@hornet>
References: <20140212024904.GA19352@roeck-us.net>
 <1392206196.848.18.camel@hornet>
Message-ID: <20140212164134.GA19445@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:56:36AM +0000, Pawel Moll wrote:
> 
> > I agree with Arnd that it would be nice to get rid of the local macro,
> > but I won't mandate that.
> 
> I actually prefer to have the structures unfolded, but was just trying
> to mimic the trend in other hwmon drivers. No problem - will change this
> gladly.
> 
In general we tend to discourage people to use their own macros -
most of the time it just makes the code more difficult to read.

Guenter
