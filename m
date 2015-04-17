From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Apr 2015 14:23:31 +0100
Subject: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix return value check in
 s3c24xx_iis_dev_probe()
In-Reply-To: <1429186682-20629-1-git-send-email-weiyj_lk@163.com>
References: <1429186682-20629-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20150417132331.GB10513@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 08:18:02PM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150417/3f8afdef/attachment.sig>
