From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 20:31:41 -0700
Subject: [PATCH 04/15] ASoC: samsung-idma: avoid 64-bit division
In-Reply-To: <1398770316-19715-5-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-5-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501033141.GP3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:25PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> dma_addr_t may be 64 bit wide, which causes a build failure
> when doing a division on it. Here it is safe to cast to an
> u32 type, which avoids the problem.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/af3ccba8/attachment.sig>
