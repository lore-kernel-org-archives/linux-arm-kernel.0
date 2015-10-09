From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 Oct 2015 08:24:24 +0100
Subject: [PATCH v2 0/3] hwrng: st: Couple of improvements
In-Reply-To: <20151008142340.GD25166@gondor.apana.org.au>
References: <1444220609-31251-1-git-send-email-lee.jones@linaro.org>
 <20151008142340.GD25166@gondor.apana.org.au>
Message-ID: <20151009072424.GM17172@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Oct 2015, Herbert Xu wrote:

> On Wed, Oct 07, 2015 at 01:23:26PM +0100, Lee Jones wrote:
> > This set contains a minor documentation fix, greater clarification
> > with how the FIFO depth/size is represented and finally a fix to
> > prevent early timeout during data acquisition.
> > 
> > v1 => v2:
> >  - Remove phantom bugfix (FIFO really is 4 deep, not 8)
> >  - Double timeout value to account for inconsistent call to udelay()
> >    - Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> All applied.  Thanks.

Thanks Herbert.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
