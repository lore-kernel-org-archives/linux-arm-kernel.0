From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Feb 2017 16:46:45 +0000
Subject: [PATCH v4 2/3] ASoC: zx-i2s: Add the info of pclk to the binding
 document for zx2967 family
In-Reply-To: <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170209164645.ztvockrd6jxpybwt@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 11:12:57AM +0800, Baoyou Xie wrote:

> - - compatible : Must be "zte,zx296702-i2s"
> + - compatible : Must be one of:
> +	"zte,zx296718-i2s", "zte,zx296702-i2s"
> +	"zte,zx296702-i2s"

You've added the new compatible twice here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/0d1ed6f1/attachment.sig>
