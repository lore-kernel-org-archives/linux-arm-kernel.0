From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 22:12:31 +0000
Subject: Regression in 3.2.9 for omap-serial (at least)
In-Reply-To: <CAGGh5h0sC1mYFpDj973Xgbh7CQ3eGZEYVTy8qZwbsPBA_z4MRQ@mail.gmail.com>
References: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <alpine.LFD.2.02.1203081246130.2742@ionos>
 <CAGGh5h3-1XhMO1-jiBdUJYgh4unRcPonvp=zcXLKMJBfS+qpuQ@mail.gmail.com>
 <alpine.LFD.2.02.1203082024450.2742@ionos>
 <CAGGh5h0sC1mYFpDj973Xgbh7CQ3eGZEYVTy8qZwbsPBA_z4MRQ@mail.gmail.com>
Message-ID: <20120312221231.GB10830@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 08:34:44AM +0100, jean-philippe francois wrote:
> Le 8 mars 2012 20:26, Thomas Gleixner <tglx@linutronix.de> a ?crit :
> > It's in Linus tree.
> >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=52abb700e16a9aa4cbc03f3d7f80206cbbc80680
> 
> Thank you !
> In fact I don't know how to use this interface to search by commit number.
> Do you know if it is possible ?

There is no direct way to do it.

You can replace <commit-id> below with either the long commit id, or an
abbreviated commit id:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=<commit-id>

So, for commit id 52abb70,

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=52abb70

will work.
