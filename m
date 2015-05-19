From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 16:56:25 +0800
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <alpine.DEB.2.11.1505191010510.4225@nanos>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <1431769465-26867-9-git-send-email-stefan@agner.ch>
 <20150516205103.GO2067@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1505170952060.4225@nanos>
 <alpine.DEB.2.11.1505181735230.4225@nanos>
 <20150519053503.GP1071@dragon>
 <alpine.DEB.2.11.1505191010510.4225@nanos>
Message-ID: <20150519085625.GY1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 10:11:40AM +0200, Thomas Gleixner wrote:
> If you pull the irq stuff. Make sure that the HEAD is b5cc5cbc11697. I
> pushed out a broken version earlier.

Okay, thanks for the info, Thomas.  I will take care of it if rmk and
Arnd agree with the approach.

Shawn
