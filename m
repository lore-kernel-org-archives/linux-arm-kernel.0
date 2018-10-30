From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Oct 2018 16:33:19 +0000
Subject: [alsa-devel] [PATCH] ASoC: stm32: sai: fix invalid use of sizeof
 in stm32_sai_add_mclk_provider()
In-Reply-To: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
References: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20181030163319.GA6462@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2018 at 02:19:59AM +0000, Wei Yongjun wrote:
> sizeof() when applied to a pointer typed expression gives the
> size of the pointer, not that of the pointed data.

Someone else already sent a fix for this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181030/b2e07a4e/attachment.sig>
