From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Tue, 27 Dec 2016 13:22:08 +0200
Subject: [PATCH] usb: mtu3: fix U3 port link issue
In-Reply-To: <1481095393-23198-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1481095393-23198-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <87lgv11usf.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> the issue is introduced when @is_u3_ip is used in mtu3_device_enabe()
> before initialized in mtu3_mem_alloc(), so get global IP information
> at first before used by following functins.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

patch doesn't apply to my testing/fixes. Please rebase

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161227/aa13916b/attachment.sig>
