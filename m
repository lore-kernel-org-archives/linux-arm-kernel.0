From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sat, 24 Mar 2018 09:31:37 +1100
Subject: Regression with arm in next with stack protector
In-Reply-To: <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
 <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
Message-ID: <20180324093137.1658f740@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, 23 Mar 2018 12:15:30 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 23 Mar 2018 15:45:27 -0300 Fabio Estevam <festevam@gmail.com> wrote:
> 
> > On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:  
> > > Hi,
> > >
> > > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > > compressed boot phase") breaks booting on arm.  
> > 
> > Yes, almost all imx are broken in linux-next due to this commit:
> > https://kernelci.org/soc/imx/job/next/kernel/next-20180323/  
> 
> Thanks, I dropped it and I expect Stephen will also do that.

OK, dropped.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180324/1cffead6/attachment.sig>
