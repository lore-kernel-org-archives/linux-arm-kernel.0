From: buytenh@wantstofly.org ('Lennert Buytenhek')
Date: Tue, 21 Dec 2010 11:24:10 +0100
Subject: [PATCH 40/54] ARM: Samsung SoCs: irq_data conversion.
In-Reply-To: <01b901cba0f6$5d0f16a0$172d43e0$%kim@samsung.com>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130134112.GO15575@mail.wantstofly.org>
	<015801cb92e1$117861b0$34692510$%kim@samsung.com>
	<20101214221055.GA16079@mail.wantstofly.org>
	<01b901cba0f6$5d0f16a0$172d43e0$%kim@samsung.com>
Message-ID: <20101221102410.GA15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 07:03:45PM +0900, Kukjin Kim wrote:

> > > (Added Mark Brown in Cc)
> > >
> > > Looks ok to me but there are some comments.
> > >
> > > Firstly, how about to separate this to regarding S3C24XX(mach-s3c24xx
> and
> > > plat-s3c24xx), S5P(mach-s5pxxxx and plat-s5p) and plat-samsung?
> > > (Actually, already applied S3C64XX changes so that we can drop that in
> your
> > > patch.)
> > >
> > > As you know, I already applied some changes which is from Mark Brown in
> my
> > > tree.
> > > You can find that in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > > #for-next
> > >
> > > So could you please re-work this based on that?
> > 
> > I've reworked the patch I had in my tree on top of your git tree
> > (latest commit "Merge branch 'next-s5p64x0' into for-next"), and came
> > up with the three attached patches.  I've incorporated the whitespace
> > changes you requested, and changed the struct irq_data * variable
> > names from 'd' to 'data' to match Mark's earlier patches.
> > 
> > Caveat emptor -- uncompiled, and totally untested.
> > 
> > How's this look?
> > 
> > Feel free to merge this via your tree -- I'll drop the Samsung patch
> > from my tree then.
> 
> Hi Lennert :-)

Hello,


> I found your different e-mail in your patch like following.
> 
> "From: Lennert Buytenhek <buytenh@wantstofly.org>"
> ...
> "Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>"
> 
> I think, should be used same e-mail address.
> Which one do you want to use?...

I don't think there is a requirement to use the same one for both,
but if it bothers you, please use the latter one.


thanks,
Lennert
