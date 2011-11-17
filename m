From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:04:58 +0000
Subject: [PATCH v7 01/11] ARM: mmp: fix build error on gpio
In-Reply-To: <201111171700.59750.arnd@arndb.de>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
 <201111171516.24237.arnd@arndb.de>
 <CAMPhdO-27ZMV+z5b8j1NEPmUMHx=6cOe0dxvDgbM+2KGeAWXKg@mail.gmail.com>
 <201111171700.59750.arnd@arndb.de>
Message-ID: <20111117170458.GW9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:00:59PM +0000, Arnd Bergmann wrote:
> On Thursday 17 November 2011, Eric Miao wrote:
> > Yeah, but having a patch here really helps to make a buildable
> > state of the history.
> > 
> > Shall I go ahead and send the GIT PULL with this patch? or you have
> > another idea?
> 
> Actually it turns out that Russell has already sent an identical
> fix upstream, and that has made it into 3.2-rc1, so I think it should
> be fine now without your patch.

I sent one for PXA for rc1, but missed MMP.  So the MMP one is still
required.
