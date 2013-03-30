From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 12:56:18 +0000
Subject: [PATCH v3 7/7] USB: OHCI: avoid conflicting platform drivers
In-Reply-To: <Pine.LNX.4.44L0.1303291612370.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291612370.1467-100000@iolanthe.rowland.org>
Message-ID: <201303301256.19027.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013, Alan Stern wrote:
> I have not checked the details of all the changes; however, the basic
> idea is okay as a stop-gap measure.

Ok, thanks. 

> I guess this means the onus is now on me to split up ohci-hcd into a 
> central library and separate bus drivers, like ehci-hcd...

The original plan in my teams was that Manjunath would do that after
he was done with the simple conversion of the EHCI drivers. I think we
can all agree now that it's better if you at least the groundwork instead.

Please let us know if you would like Manjunath to continue with splitting
out the OHCI back-ends into separate drivers, or if you think that there
is no point given the quality of the earlier patches.

	Arnd
