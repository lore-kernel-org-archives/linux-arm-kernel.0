From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 23 Mar 2018 12:15:30 -0700
Subject: Regression with arm in next with stack protector
In-Reply-To: <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
Message-ID: <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Mar 2018 15:45:27 -0300 Fabio Estevam <festevam@gmail.com> wrote:

> On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > compressed boot phase") breaks booting on arm.
> 
> Yes, almost all imx are broken in linux-next due to this commit:
> https://kernelci.org/soc/imx/job/next/kernel/next-20180323/

Thanks, I dropped it and I expect Stephen will also do that.
