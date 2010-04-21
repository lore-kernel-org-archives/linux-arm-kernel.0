From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Apr 2010 10:32:45 -0400 (EDT)
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <1271838700.2330.143.camel@pasglop>
References: <1271838486.2330.139.camel@pasglop>
	<1271838700.2330.143.camel@pasglop>
Message-ID: <alpine.LFD.2.00.1004211030510.7232@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Apr 2010, Benjamin Herrenschmidt wrote:

> Oh a couple more things...
> 
> The fans are controlled via 2 GPIOs on this (see the explanation in the
> patch). Do you guys think I should create some kind of pseudo hwmon
> device so it can be controlled with one file where you write "off",
> "low", "high", or should I just let userspace cope.

If you fancy doing such thing then that would be more user friendly.  
And that could provide a common abstraction for all models.


Nicolas
