From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 14 Jul 2011 15:10:37 -0500
Subject: [RFC 0/6] watchdog drivers converted to the new framework
In-Reply-To: <20110714200053.GC31082@pengutronix.de>
References: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05B65@AUSP01VMBX24.collaborationhost.net>
	<20110714182734.GA31082@pengutronix.de>
	<ADE657CA350FB648AAC2C43247A983F001F383E05BCD@AUSP01VMBX24.collaborationhost.net>
	<20110714200053.GC31082@pengutronix.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383E05C4A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 14, 2011 1:01 PM, Wolfram Sang wrote:
> On Thu, Jul 14, 2011 at 01:42:02PM -0500, H Hartley Sweeten wrote:
>> On Thursday, July 14, 2011 11:28 AM, Wolfram Sang wrote:
>>>> I would also like to convert this driver into a proper platform_driver using
>>>> ioremap'ed addresses instead of the static mappings.  Converting the driver
>>>> to the new watchdog framework would make this a bit cleaner.
>>>
>>> Try managed devices (devm_* and friends) for an extra cleanup bonus.
>> 
>> Already done, just waiting for the framework... ;-)
>
> Nice :) Did you use my conversion-guide as a reference? Any comments if so?

Sorry, I didn't.  I just worked it out from the framework core and looking
at your examples.

When I found the framework patches on lkml I couldn't get them into a state
to apply to my tree.  I ended up manually applying all the pieces so I skipped
the Documentation stuff to save some time.

The conversion is pretty straight forward after examining the watchdog
framework files.

Regards,
Hartley
