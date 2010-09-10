From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 9 Sep 2010 23:32:54 -0700
Subject: Voltage/current/sensor monitoring interface and Wiegand
In-Reply-To: <4C88D668.7030501@jic23.retrosnub.co.uk>
References: <20100909000245.GK14056@atomos.longlandclan.yi.org>
	<4C88D668.7030501@jic23.retrosnub.co.uk>
Message-ID: <20100910063253.GA5895@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 09, 2010 at 01:43:20PM +0100, Jonathan Cameron wrote:
> ....
> > 
> > Likewise with the PIR sensor, I notice there's a "gesture" input
> > (MSC_GESTURE)... seems appropriate?  Or am I barking up the wrong tree?
> Does it look like a button (e.g. is it a straight on off device with
> no control parameters etc)? Dmitry, what would you put this as and would
> this be acceptable in input?  

Phone guys made me add SW_FRONT_PROXIMITY at some point which is
supposed to be reported when someone covers phone screen with something
(puts into pocket or talks holding against the cheek). Could be used
here as well...

-- 
Dmitry
