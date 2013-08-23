From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Fri, 23 Aug 2013 15:19:47 -0400 (EDT)
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <20130823190247.GA3821@katana>
Message-ID: <1033284781.908504.1377285587778.JavaMail.root@mail>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram wrote:

> On Fri, Aug 23, 2013 at 02:38:20PM -0400, Vivien Didelot wrote:
> > This patch moves the at24.h header from include/linux/i2c to
> > include/linux/platform_data and updates existing support
> > accordingly.
> 
> This message explains what the patch does but not why the change is
> wanted. I'd be surprised if we really want *all* platform_data in one
> single directory?

IMHO it makes sense. Why wouldn't we want all platform_data in
include/linux/platform_data/?

> Is this patch part of a bigger series?
No.

> That being said i2c is not the best place for this include, in deed...
I agree.

Thanks,
Vivien
