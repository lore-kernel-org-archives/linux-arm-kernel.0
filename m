From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 18 Sep 2016 21:04:30 +0200
Subject: [PATCH -next] drm/sun4i: backend: remove redundant dev_err call
 in sun4i_backend_bind()
In-Reply-To: <1473909958-30216-1-git-send-email-weiyj.lk@gmail.com>
References: <1473909958-30216-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160918190430.GF17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 03:25:58AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Queued, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160918/257caa2c/attachment.sig>
