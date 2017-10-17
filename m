From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 17 Oct 2017 12:20:59 +0200
Subject: [PATCH v2 7/9] usb: host: modify description for MTK xHCI config
In-Reply-To: <59E0962E.9030508@linux.intel.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
 <37153cd259af6e1fc34b32a2e0dd1a15b8214579.1507882470.git.chunfeng.yun@mediatek.com>
 <59E0962E.9030508@linux.intel.com>
Message-ID: <20171017102059.GA17121@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 01:32:14PM +0300, Mathias Nyman wrote:
> On 13.10.2017 11:26, Chunfeng Yun wrote:
> > Due to all MediaTek SoCs with xHCI host controller use this
> > driver, remove limitation for specific SoCs
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> 
> xHCI parts of series look good to me, If Rob Herring agrees with the
> dt changes I can send it forward

If you ack them, I can just take the whole series as-is.

thanks,

greg k-h
