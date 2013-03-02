From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 2 Mar 2013 11:58:28 +0800
Subject: [PATCH -next] spi: fix return value check in ce4100_spi_probe()
In-Reply-To: <CAPgLHd-PhE2igUQOeg90H98Ni55DwfYdp0D52uaBK0=J3M1V+g@mail.gmail.com>
References: <CAPgLHd-PhE2igUQOeg90H98Ni55DwfYdp0D52uaBK0=J3M1V+g@mail.gmail.com>
Message-ID: <20130302035825.GG6610@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 10:52:35AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function platform_device_register_full()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130302/74312f0b/attachment.sig>
