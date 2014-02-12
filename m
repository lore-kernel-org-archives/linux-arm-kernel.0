From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 12 Feb 2014 11:59:27 +0000
Subject: [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device
 registration
In-Reply-To: <1392206196.848.18.camel@hornet>
References: <20140212024904.GA19352@roeck-us.net>
 <1392206196.848.18.camel@hornet>
Message-ID: <1392206367.848.20.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-12 at 11:56 +0000, Pawel Moll wrote:
> > Third, I noticed that the 'label' attribute is always created but returns  
> > -ENOENT if there is no label. A much better implementation would be to use
> > .is_visible and not create the label attribute if its devicetree entry
> > does not exist. I don't know how libsensors reacts to -ENOENT on a read,
> > but no matter how it does react, it is pretty much undefined.
> > Again, that should be handled in a separate patch.

Missed that one - will do as well.

Pawel
