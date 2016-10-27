From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 27 Oct 2016 17:05:55 +0200
Subject: [PATCH v7, 0/8] Add MediaTek USB3 DRD Driver
In-Reply-To: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20161027150555.GA13414@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 10:28:19AM +0800, Chunfeng Yun wrote:
> These patches introduce the MediaTek USB3 dual-role controller
> driver.
> 
> The driver can be configured as Dual-Role Device (DRD),
> Peripheral Only and Host Only (xHCI) modes. It works well
> with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
> tested on MT8173 platform which only contains USB2.0 device IP,
> and on MT6290 platform which contains USB3.0 device IP.
> 
> Change in v7:
> 1. split dual-role driver into four patchs
> 2. remove QMU done tasklet
> 3. add a bool in xhci_hcd_mtk to signal absence of IPPC

Given a lack of objection from anyone, I've now merged these to my tree
to get them a spin in the 0-day build-bot.

thanks,

greg k-h
