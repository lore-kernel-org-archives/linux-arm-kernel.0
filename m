From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Mon, 29 Aug 2016 11:01:02 +0300
Subject: [RESEND PATCH, v5 3/5] usb: xhci-mtk: make IPPC register optional
In-Reply-To: <1472094329-18466-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1472094329-18466-1-git-send-email-chunfeng.yun@mediatek.com>
 <1472094329-18466-4-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <877fb0dmwx.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> Make IPPC register optional to support host side of dual-role mode,
> due to it is moved into common glue layer for simplification.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Mathias? Are you taking these patches?? I don't wanna take peripheral
side driver if you won't take xhci side.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/18a8eb6b/attachment.sig>
