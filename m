From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Sep 2016 17:32:58 +0900
Subject: [PATCH v2 0/3] arm64: kgdb: fix single stepping
In-Reply-To: <20160923081618.GH18056@kroah.com>
References: <20160923073327.9657-1-takahiro.akashi@linaro.org>
 <20160923081618.GH18056@kroah.com>
Message-ID: <20160923083257.GL30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 10:16:18AM +0200, Greg KH wrote:
> On Fri, Sep 23, 2016 at 04:33:24PM +0900, AKASHI Takahiro wrote:
> > Kgdb support on arm64 was merged in v3.15, but from its first appearance,
> > "signle step" has never worked well.
> > 
> > This patch fixes all the error cases I found so far.
> > The original patch[1] was splitted into three pieces, ones for each case.
> > patch#1, #2 should be applied to all the version, v3.15 and later.
> > pathc#3 only for v3.16 and later.
> 
> As this is not a regression (i.e. it has never worked), why is this
> something for stable releases?

Because, I think, that is a bug.
The author seems to have believed that it worked.
Please see:
  commit 44679a4f
  Author: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
  Date:   Tue Jan 28 11:20:19 2014 +0000

      arm64: KGDB: Add step debugging support

Thanks,
-Takahiro AKASHI

> thanks,
> 
> greg k-h
