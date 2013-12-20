From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Dec 2013 12:00:15 +0000
Subject: [PATCH -next] spi: nuc900: remove redundant return value check
 of platform_get_resource()
In-Reply-To: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
References: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
Message-ID: <20131220120015.GT31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 10:21:54AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/60ba73d9/attachment.sig>
