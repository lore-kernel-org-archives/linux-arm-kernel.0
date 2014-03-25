From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 13:11:39 +0000
Subject: [RFC 00/47] mtd: nand: Add new driver supporting ST's BCH h/w
In-Reply-To: <20140325125050.GB665@arch.cereza>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <20140325125050.GB665@arch.cereza>
Message-ID: <20140325131139.GB24823@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Mar 2014, Ezequiel Garcia wrote:

> Hi Lee,
> 
> On Mar 25, Lee Jones wrote:
> > 
> > This patch-set was written against kernel version v3.4, but applies
> > cleanly to v3.13-rc7 which it is currently based. I understand that
> > the core has changed significantly since and that some of the
> > infrastructure this driver provides is now available either through
> > the framework or similar means. I'm looking for someone with inside
> > knowledge to draw attention to those areas so we can align with the
> > most recent API.
> > 
> 
> Please push a git branch. It will be nice to have a way of seeing the 'big
> picture' without applying the 47 patches.

Sure:

  git://git.linaro.org/people/lee.jones/linux-3.0-ux500.git tb-st-mtd-nand-bch

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
