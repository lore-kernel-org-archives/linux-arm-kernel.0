From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 18:28:11 +0100
Subject: [PATCH -next] spi/rockchip: remove redundant dev_err call in
 rockchip_spi_probe()
In-Reply-To: <1405864902-14056-1-git-send-email-weiyj_lk@163.com>
References: <1405864902-14056-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20140725172811.GW17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 10:01:42PM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/ccc27f5b/attachment-0001.sig>
