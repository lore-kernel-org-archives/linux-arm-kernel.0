From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sun, 9 Oct 2016 14:50:28 +0800
Subject: [RESEND PATCH v6, 3/5] usb: xhci-mtk: make IPPC register optional
In-Reply-To: <1474437277-27201-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
 <1474437277-27201-4-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1475995828.15546.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-21 at 13:54 +0800, Chunfeng Yun wrote:
> Make IPPC register optional to support host side of dual-role mode,
> due to it is moved into common glue layer for simplification.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk.c |   36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)

Hi Mathias,

    Would you please take a little time out of your busy schedule and
help review this patch?

    Thank you very much.
