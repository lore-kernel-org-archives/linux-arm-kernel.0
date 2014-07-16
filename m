From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 16 Jul 2014 08:44:32 +0800
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <20140715152437.GF1011@kwain>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <CAGnW=BbA3gLdSv8AKkD_ysnYAaN0KoCdVW+wxWPB9zzGCh9+jQ@mail.gmail.com>
 <20140715152437.GF1011@kwain>
Message-ID: <20140716004431.GB30419@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 05:24:37PM +0200, Antoine T?nart wrote:
> Hi,
> 
> On Thu, Jul 03, 2014 at 08:17:34AM +0530, punnaiah choudary kalluri wrote:
> > Since its a generic driver, support for configuring the dma_mask using
> > dma_coerce_mask_and_coherent would be good.
> > 
> 
> Should I add a DMA mask dt property? Or just not add this and wait for
> someone needing it in his case?
> 

As a dt property, since most of platforms will use it. For PIO mode, the
property can be NULL.

-- 

Best Regards,
Peter Chen
