From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 21:45:58 -0700
Subject: [GIT PULL 5/6] Samsung s3c24xx-dma for v3.13
In-Reply-To: <526455FD.3070702@samsung.com>
References: <526455FD.3070702@samsung.com>
Message-ID: <20131028044558.GK22890@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:15:25AM +0900, Kukjin Kim wrote:
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
> 
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/s3c24xx-dma
> 
> for you to fetch changes up to 1fecf8958eb7f90791f2c7e99afac393b64fa976:
> 
>   ARM: S3C24XX: add dma pdata for s3c2410, s3c2440 and s3c2442
> (2013-10-21 05:32:48 +0900)
> 
> ----------------------------------------------------------------
> add dmaengine based s3c24xx dma driver

Thanks, pulled into next/drivers.

But please write better tag descriptions. What I ended up writing up for this
was:


    From Kukjin Kim, this branch adds device-tree support to the DMA controller
    on the older Samsung SoCs. It also adds support for one of the missing SoCs
    in the family (2410).
    
    The driver has been Ack:ed by Vinod Koul, but is merged through here due
    to dependencies with platform code.



-Olof
