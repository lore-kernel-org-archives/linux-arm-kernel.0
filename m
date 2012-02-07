From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 Feb 2012 17:18:38 +0100
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
In-Reply-To: <4F314D0C.50501@kernelconcepts.de>
References: <20120207152903.GA16238@lunn.ch> <4F314D0C.50501@kernelconcepts.de>
Message-ID: <20120207161838.GF15165@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Apart from my joy - the basic reason for that change would be still
> interesting? Does this only apply to Kirwoods or my special board?

I think the conversation fizzled out without coming to a conclusion
what is wrong. Look back in the archives and see what you can find.
The problem hits kirkwood, but i don't know if it also affects other
Orion based processors. u-boot also play a role in the problem...

      Andrew
