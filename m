From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 15:33:34 +0100
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available for
 ARM_UNWIND
In-Reply-To: <CA+KhAHYvbxANa84FMDVV96udwhif2P2_XirPhWVWTKy_8iK72A@mail.gmail.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <20130128125023.GA2027@linaro.org>
 <CA+KhAHYvbxANa84FMDVV96udwhif2P2_XirPhWVWTKy_8iK72A@mail.gmail.com>
Message-ID: <201401071533.35309.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Keun-O Park wrote:
> On Mon, Jan 28, 2013 at 9:50 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > On Mon, Jan 28, 2013 at 11:33:11AM +0900, Keun-O Park wrote:
> >> Hello guys,
> >>
> >> Could you please review the patch of fixing bug first of returning
> >> wrong address when using frame pointer?
> >> I am wondering if the first patch is not delivered to the mailing.
> >
> > I posted a similar patch to alkml a couple of months ago, but I got
> > no response and it looks like I forgot about it.
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129381.html
> 
> Yes, same except initialization of data.addr. :)
> This means there might be no one interested in using
> ftrace-irqsoff/premptoff in ARM during a couple of months?


It's been almost a year since we last discussed the patches that were
posted by Dave and sahara, but nothing has changed in the mainline kernel.

Any chance that someone could be motivated to pick this work up again
and finally fix return_address().

	Arnd
