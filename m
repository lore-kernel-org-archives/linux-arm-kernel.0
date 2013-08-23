From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 23 Aug 2013 23:26:36 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbWlzYzogKGF0MjQpIG1vdmUgaGVhZGVyIHRvIGxpbnV4?=
 =?UTF-8?B?L3BsYXRmb3JtX2RhdGEv?=
In-Reply-To: <1033284781.908504.1377285587778.JavaMail.root@mail>
References: <20130823190247.GA3821@katana>
 <1033284781.908504.1377285587778.JavaMail.root@mail>
Message-ID: <1377285996.620418788@f48.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Wolfram wrote:
> 
> > On Fri, Aug 23, 2013 at 02:38:20PM -0400, Vivien Didelot wrote:
> > > This patch moves the at24.h header from include/linux/i2c to
> > > include/linux/platform_data and updates existing support
> > > accordingly.
> > 
> > This message explains what the patch does but not why the change is
> > wanted. I'd be surprised if we really want *all* platform_data in one
> > single directory?
> 
> IMHO it makes sense. Why wouldn't we want all platform_data in
> include/linux/platform_data/?

Can this file be additionally renamed to misc-at24.h to reflect belongs
to a particular subsystem?

---
