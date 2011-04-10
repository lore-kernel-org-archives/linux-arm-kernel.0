From: greg@kroah.com (Greg KH)
Date: Sun, 10 Apr 2011 09:20:33 -0700
Subject: [RFC][WAS:bcmai][PATCH V2] axi: add AXI bus driver
In-Reply-To: <BANLkTinZbw=GvkThyjMHbeQQ5arRVf2FUg@mail.gmail.com>
References: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
	<20110408220157.GC26019@kroah.com>
	<BANLkTinZbw=GvkThyjMHbeQQ5arRVf2FUg@mail.gmail.com>
Message-ID: <20110410162033.GA4358@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2011 at 05:52:27PM +0200, Rafa? Mi?ecki wrote:
> 2011/4/9 Greg KH <greg@kroah.com>:
> > On Fri, Apr 08, 2011 at 09:45:00PM +0200, Rafa? Mi?ecki wrote:
> >> TODO:
> >> - Interrupts
> >> - Reloading driver
> >
> > Please add to the TODO list:
> > ? ? ? ?- Documentation/ABI entries for new sysfs files
> > ? ? ? ?- proper Kconfig entry documentation for the different options
> 
> Could you tell me sth more about this? How am I expected to document this stuff?
> 
> Should I create Documentation/ABI/testing/sysfs-bus-axi or what?
> 
> Of course you can just point me to some place where I can read about
> proper documenting.

Documentation/ABI/README
