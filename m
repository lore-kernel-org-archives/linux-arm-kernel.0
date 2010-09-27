From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Sep 2010 15:28:17 -0700
Subject: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
In-Reply-To: <4C99BD55.3070706@compulab.co.il>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
	<1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
	<AANLkTin+canp9yrE-Jmv=n56dPFByZWU73uaRNBkruP6@mail.gmail.com>
	<4C99BD55.3070706@compulab.co.il>
Message-ID: <20100927222817.GF16721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [100922 01:16]:
> 
> > It should be okay to execute this code independent of whether
> > the driver is built or not. The device registration can be unconditional
> > and if there is no driver present, we won't probe anyway.

The current patch looks OK to me, adding all of them into omap-for-linus.

Regards,

Tony
