From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 18:15:17 +0000
Subject: [PATCH v2 16/16] ARM: dts: Fix I2S1, I2S2 compatible for exynos4
 SoCs
In-Reply-To: <1418997336-17777-17-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-17-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150106181517.GQ2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 02:55:36PM +0100, Sylwester Nawrocki wrote:
> I2S1, I2S2 on Exynos4 SoC series have limited functionality compared
> to I2S0, "samsung,s3c6410-i2s" compatible should be used for them.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

This should probably go to stable as a bug fix too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/fd06a10a/attachment.sig>
