From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Fri, 10 Jun 2016 12:21:33 +0300
Subject: [PATCH v3,2/5] dt-bindings: mt8173-mtu3: add devicetree bindings
In-Reply-To: <1465543962-11678-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
 <1465543962-11678-3-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <878tyd761u.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> + - enable-manual-drd : supports manual dual-role switch via sysfs; only used
> +	when receptacle is TYPE-A and also wants to support dual-role mode.

sorry, but this manual-drd can't be accepted. You should rely on a DT
property for this and you shouldn't expose it to sysfs. Use DebugFS for
that.


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/ae48bff0/attachment.sig>
