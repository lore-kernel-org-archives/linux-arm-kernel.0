From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Oct 2015 12:24:17 +0000
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <1446034810.2757.87.camel@perches.com>
References: <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
 <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
 <1446030399.2757.83.camel@perches.com>
 <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
 <20151028113932.GS5828@x1> <20151028121454.GA4058@x1>
 <1446034810.2757.87.camel@perches.com>
Message-ID: <20151028122417.GB4058@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015, Joe Perches wrote:
> On Wed, 2015-10-28 at 12:14 +0000, Lee Jones wrote:
> > Ah, but wait.  get_maintainer.pl *does* assume M means Maintainer
> > doesn't it?
> 
> No, it looks at the "S:" line.

Right.  Then assumes because the driver is 'supported' or 'maintained'
that the person(s) listed in M: must be the Supporter(s) or the
Maintainer(s).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
