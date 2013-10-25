From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Oct 2013 10:26:30 +0100
Subject: [PATCH] ASoC: Samsung: I2S: fix return value check in
 i2s_alloc_dai()
In-Reply-To: <CAPgLHd8nzO9Q1fF1KsuJna_JVJDd+cimBC3ipd3nTP9Sz=fE9g@mail.gmail.com>
References: <CAPgLHd8nzO9Q1fF1KsuJna_JVJDd+cimBC3ipd3nTP9Sz=fE9g@mail.gmail.com>
Message-ID: <20131025092630.GQ18506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 05:06:24PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function platform_device_alloc() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/56021175/attachment.sig>
