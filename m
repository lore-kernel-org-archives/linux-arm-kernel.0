From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Feb 2012 06:28:00 +0000
Subject: [PATCH 0/6] ux500: Export SoC information and some platform
 clean-up
In-Reply-To: <20120210194358.GA5537@kroah.com>
References: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
 <20120210194358.GA5537@kroah.com>
Message-ID: <201202130628.01081.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 February 2012, Greg KH wrote:
> On Mon, Feb 06, 2012 at 11:22:20AM -0800, Lee Jones wrote:
> > This patch-set satisfies 4 objectives:
> >  1. Ensures each platform device can specify a suitable parent
> >  2. Provides a bus for SoC devices as a means to export information
> >  3. Allows ux500 to make use of the new SoC bus
> >  4. Cleans up unnecessary complexity from ux500 code
> 
> I've applied the driver-core bits, nice job in sticking with this.  I'll
> let the other bits trickle through the arch-specific trees.

Ok, very good. Thanks both of you for your patience. I'm looking forward
to many good patches from Lee now that he has made it through this.

IIRC it was mostly an attempt for Lee to start contributing one of the
"simpler" patches from the st-ericsson internal tree in order to get
started. My feeling is that almost any other patch would have been easier
because it does not involve infrastructure and APIs, but this was certainly
a learning experience ;-).

I've applied the ux500 patches onto the ux500/soc branch of the arm-soc
tree now and added the current head of the driver-core tree as the
next/driver-core branch in the same tree. I will keep track of this
and send out the ux500 patches during the next merge window after the
core changes have been merged. Other platforms are very welcome to
send patches based on the same interface for 3.4. I know from working
with Greg that he does not rebase his trees, so I assume this is the
best approach.

	Arnd
