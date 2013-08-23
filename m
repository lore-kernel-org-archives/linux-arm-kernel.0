From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 10:37:15 +0100
Subject: [PATCH -next] spi: sirf: fix error return code in
 spi_sirfsoc_probe()
In-Reply-To: <CAPgLHd8sTqQX-orB1VjED4hcpwU577TgqfQV=eRYCk-vjzdYOQ@mail.gmail.com>
References: <CAPgLHd8sTqQX-orB1VjED4hcpwU577TgqfQV=eRYCk-vjzdYOQ@mail.gmail.com>
Message-ID: <20130823093715.GD25263@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 08:33:39AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/af72de61/attachment.sig>
