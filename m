From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 18:00:39 +0100
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <alpine.LFD.2.03.1307171148160.14924@syhkavp.arg>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374052705.3146.86.camel@hornet>
 <alpine.LFD.2.03.1307170825240.14924@syhkavp.arg>
 <1374067786.3146.123.camel@hornet>
 <alpine.LFD.2.03.1307171014510.14924@syhkavp.arg>
 <1374070811.3146.124.camel@hornet>
 <alpine.LFD.2.03.1307171148160.14924@syhkavp.arg>
Message-ID: <20130717170038.GP24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 11:57:55AM -0400, Nicolas Pitre wrote:
> The sanest location at this point might simply be 
> drivers/platform/vexpress_spc.c or drivers/platform/vexpress/spc.c 
> depending on whether or not more such driver glue is expected in the 
> vexpress future.  No point putting "arm" in the path, especially if this 
> is later reused on arm64.

You wouldn't be making that argument if it were arch/arm64 and arch/arm32 -
you'd probably be arguing that "arm" made perfect sense.

Don't get too hung up on names please, it's really not worth the time
and effort being soo pedantic, and being soo pedantic leads to "pointless
churn" when someone comes along and wants to pedantically change the
names because it no longer matches the users.
