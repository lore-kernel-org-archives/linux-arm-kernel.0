From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 18:28:22 +0100
Subject: [PATCH -next] spi/rockchip: fix error return code in
 rockchip_spi_probe()
In-Reply-To: <1405864924-14137-1-git-send-email-weiyj_lk@163.com>
References: <1405864924-14137-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20140725172822.GX17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 10:02:04PM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return -EINVAL from the error handling case instead of 0 when
> failed to get fifo length.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/66ad94d4/attachment.sig>
