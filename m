From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 15 Jul 2014 17:24:37 +0200
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <CAGnW=BbA3gLdSv8AKkD_ysnYAaN0KoCdVW+wxWPB9zzGCh9+jQ@mail.gmail.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <CAGnW=BbA3gLdSv8AKkD_ysnYAaN0KoCdVW+wxWPB9zzGCh9+jQ@mail.gmail.com>
Message-ID: <20140715152437.GF1011@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 03, 2014 at 08:17:34AM +0530, punnaiah choudary kalluri wrote:
> Since its a generic driver, support for configuring the dma_mask using
> dma_coerce_mask_and_coherent would be good.
> 

Should I add a DMA mask dt property? Or just not add this and wait for
someone needing it in his case?

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
