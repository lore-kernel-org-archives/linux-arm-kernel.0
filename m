From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Apr 2015 14:46:03 -0500
Subject: [PATCH] usb: gadget: xudc: fix return value check in xudc_probe()
In-Reply-To: <1429186650-20465-1-git-send-email-weiyj_lk@163.com>
References: <1429186650-20465-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20150427194603.GB25136@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 16, 2015 at 08:17:30PM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

doesn't apply to v4.1-rc1, if it's still needed, please rebase.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/d4a38313/attachment.sig>
