From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 21:11:09 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <51439BDF.3050300@cogentembedded.com>
References: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
 <201303152015.31292.arnd@arndb.de> <51439BDF.3050300@cogentembedded.com>
Message-ID: <201303152111.09705.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Sergei Shtylyov wrote:
> >
> > a) Apply Roger's patch for 3.9, and add my "USB: EHCI: DT support
> >     for generic bus glue" patch on top after it has been tested
> 
>     Arnd, sorry, where can I find this patch? Archive search doesn't 
> turn up anything...

It's in this email thread, in one of my earlier replies to Alan. Since
Greg already said that he won't take Roger's patch for 3.9, taking
this one would be pointless as well. I can resubmit it for 3.10
once we know what to do about my hot-fix.

	Arnd
