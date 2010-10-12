From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 13 Oct 2010 01:25:14 +0200
Subject: [PATCH v7] power: introduce library for device-specific OPPs
In-Reply-To: <201010120008.16388.rjw@sisk.pl>
References: <[PATCH] power: introduce library for device-specific OPPs>
	<4CB32675.1090205@ti.com> <201010120008.16388.rjw@sisk.pl>
Message-ID: <201010130125.14604.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 12, 2010, Rafael J. Wysocki wrote:
> On Monday, October 11, 2010, Nishanth Menon wrote:
> > Rafael J. Wysocki had written, on 10/09/2010 05:59 PM, the following:
> > [...]
> > >>
> > >> Signed-off-by: Nishanth Menon <nm@ti.com>
> > > 
> > > OK
> > > 
> > > Your error messages are a bit inconsistent (e.g. some of them print the
> > > error code while others don't), but I guess I can fix that up.
> > Thanks a bunch.
> > > 
> > > Still, to apply the patch I need a copyright notice for the doc too.
> > oops..
> > (C) 2009-2010 Nishanth Menon <nm@ti.com>, Texas Instruments Incorporated
> > Does this help?
> 
> Yes, it does.
> 
> > or would you like me to post a v8 as well?
> 
> That shouldn't be necessary.

The patch has been applied to suspend-2.6/linux-next at:

http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commit;h=56149b574181d98aedf97f1f2d91d05ab261db41

with minor changes around the error messages.  Please double check if everything
is correct.

Thanks,
Rafael
