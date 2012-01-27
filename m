From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 17:15:01 +0900
Subject: [PATCH] arm: Fix missing api-change from subsys_interface change
In-Reply-To: <201201270910.34247.heiko@sntech.de>
References: <201201121430.49448.heiko@sntech.de>
 <20120112160605.GA10831@suse.de>
 <033301ccd18f$64ac8c60$2e05a520$%kim@samsung.com>
 <201201270910.34247.heiko@sntech.de>
Message-ID: <01b101ccdccb$c41b0a40$4c511ec0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Freitag, 13. Januar 2012, 02:05:08 schrieb Kukjin Kim:
> > Greg KH wrote:
> > > On Thu, Jan 12, 2012 at 02:30:48PM +0100, Heiko St?bner wrote:
> > > > Commit 4a858cfc9a (arm: convert sysdev_class to a regular subsystem)
> > > > converted the samsung sysdevs into subsys_interface instances.
> > > >
> > > > While the original add-function only had a (struct sys_device *)
> > > > parameter, the dev_add from subsys_interface needs
> > > >
> > > > 	(struct device *, struct subsys_interface *)
> > > >
> > > > leading to "initialized from incompatible pointer type" warnings.
> > > >
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > > The patch applies cleanly against the current driver-core git,
> > > > hopefully it's the right tree.
> > >
> > > Thanks for fixing this up, sorry for getting it wrong.
> > >
> > > This should be done against the Samsung arm git tree, and go in through
> > > that one.  The driver-core git tree is equal to Linus's tree of a few
> > > days ago, there are no driver-core patches in it at the moment.
> > >
> > > Kukjin, can you take these?
> >
> > Sure, let me pick this up in my fixes.
> 
> Hi Kgene,
> 
> ping :-)
> 
> I checked the hopefully correct branch v3.3-samsung-fixes and the patch is not
> in there.
> 
Hi,

I already applied it in my local tree, v3.3-samsung-fixes-2 but not pushed yet :)
Will be sent in this weekend.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
