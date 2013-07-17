From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Jul 2013 14:29:46 +0100
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <alpine.LFD.2.03.1307170825240.14924@syhkavp.arg>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374052705.3146.86.camel@hornet>
 <alpine.LFD.2.03.1307170825240.14924@syhkavp.arg>
Message-ID: <1374067786.3146.123.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-17 at 13:33 +0100, Nicolas Pitre wrote:
> If this is really miscelaneous code that really doesn't fit 
> anywhere else, it should rather go into drivers/misc/ as a last resort.

Interestingly enough drivers/misc was my first choice for all the
vexpress stuff, but it wasn't received well...

Anyway, the SPC driver as it is now seem to be a "power management
system driver". Maybe a relevant directory would be in place? Wouldn't
PSCI belong there as well? (there are two psci.c files in arch/arm and
arch/arm64, surprisingly similar ones ;-)

The bottom line is: today it is not an MFD driver.

Pawe?
