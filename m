From: treding@nvidia.com (Thierry Reding)
Date: Tue, 7 Mar 2017 12:02:39 +0100
Subject: [PATCH 2/2] usb: xhci: remove dummy extra_priv_size for size of
 xhci_hcd struct
In-Reply-To: <1488857543-9384-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
 <1488857543-9384-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20170307110238.GA31069@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 11:32:23AM +0800, Chunfeng Yun wrote:
> because hcd_priv_size is already size of xhci_hcd struct,
> extra_priv_size is not needed anymore for MTK and tegra drivers.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk.c   |    1 -
>  drivers/usb/host/xhci-tegra.c |    1 -
>  2 files changed, 2 deletions(-)

For Tegra:

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/e812618a/attachment.sig>
