From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 10:26:31 +0200
Subject: [PATCH -next] clk: sunxi-ng: de2: fix wrong pointer passed to
 PTR_ERR()
In-Reply-To: <20170518155513.29628-1-weiyj.lk@gmail.com>
References: <20170518155513.29628-1-weiyj.lk@gmail.com>
Message-ID: <20170519082631.epwxqh3dqhxr6va5@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 03:55:13PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Fixes: b0d9a4bd52bd ("clk: sunxi-ng: add support for DE2 CCU")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/3c6fb3d9/attachment.sig>
