From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 22 Jul 2011 19:55:39 +0200
Subject: [RFC 0/6] watchdog drivers converted to the new framework
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F383E05C4A@AUSP01VMBX24.collaborationhost.net>
References: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05B65@AUSP01VMBX24.collaborationhost.net>
	<20110714182734.GA31082@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05BCD@AUSP01VMBX24.collaborationhost.net>
	<20110714200053.GC31082@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05C4A@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110722175539.GC31767@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

> >>>> I would also like to convert this driver into a proper platform_driver using
> >>>> ioremap'ed addresses instead of the static mappings.  Converting the driver
> >>>> to the new watchdog framework would make this a bit cleaner.
> >>>
> >>> Try managed devices (devm_* and friends) for an extra cleanup bonus.
> >> 
> >> Already done, just waiting for the framework... ;-)
> >
> > Nice :) Did you use my conversion-guide as a reference? Any comments if so?
> 
> Sorry, I didn't.  I just worked it out from the framework core and looking
> at your examples.
> 
> When I found the framework patches on lkml I couldn't get them into a state
> to apply to my tree.  I ended up manually applying all the pieces so I skipped
> the Documentation stuff to save some time.
> 
> The conversion is pretty straight forward after examining the watchdog
> framework files.

Maybe you could allready post your patches to the linux watchdog mailing list.

Kind regards,
Wim.
