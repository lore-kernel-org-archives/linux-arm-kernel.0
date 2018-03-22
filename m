From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 22 Mar 2018 10:01:27 +0100
Subject: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of
 shared hcd
In-Reply-To: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
Message-ID: <20180322090127.GA12048@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 04:39:20PM +0800, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from version 1?

Always put that below the --- line like the kernel documentation asks
you to do.

v3?

thanks,

greg k-h
