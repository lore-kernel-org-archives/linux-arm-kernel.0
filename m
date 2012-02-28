From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 28 Feb 2012 13:11:06 -0000
Subject: [PATCH v2] ARM: LPC32xx: Ethernet driver
In-Reply-To: <4F4CD1D8.8030102@antcom.de>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E83@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> Thanks for the note! I actually found out that in many cases, the
> bootloader already initialized the hardware with the target 
> MAC address so we can use this one.
> 
> For the case that it _isn't_ initialized already, is it the right
thing
> to use a hard coded default MAC address to be replaced by the final
one
> in userspace? (I found such examples in some current micrel/ and amd/
drivers.)

Using a fixed address is a very bad idea ...

	David
