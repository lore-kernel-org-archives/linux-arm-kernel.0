From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 22 Mar 2018 13:53:00 +0100
Subject: [usb-next, v3 PATCH] usb: xhci: skip phys initialization of
 shared hcd
In-Reply-To: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
Message-ID: <20180322125300.GA22130@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 08:12:50PM +0800, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.

Wait, why does the subject say "xhci", when this is in USB core code?

I'll go edit that by hand...
