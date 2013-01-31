From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 01:49:12 +0000
Subject: Failure to boot...
Message-ID: <20130131014912.GM2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having spent today sorting out the Realview EB boot, the last thing
I expected to find was that both my OMAP platforms are unbootable
to the point that absolutely nothing happens after the boot loader
transfers control.

I've not been running the boots for about a month, so I'm not sure
when this breakage crept in.

You can see the results in the boot logs on the website.  Please
investigate.  And I'll try without arm-soc tomorrow.

Very disappointed that the ARM kernel seems to be rather screwed at
the moment across multiple sub-arches.
