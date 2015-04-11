From: broonie@kernel.org (Mark Brown)
Date: Sat, 11 Apr 2015 23:05:28 +0100
Subject: [PATCH] ASoC: rnsd: fix build regression without CONFIG_OF
In-Reply-To: <6164726.dCMByIoYOc@wuerfel>
References: <6164726.dCMByIoYOc@wuerfel>
Message-ID: <20150411220528.GW6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 12:18:37AM +0200, Arnd Bergmann wrote:
> The r-car sound driver only works when CONFIG_OF is set, and
> after a recent change has a compile-time dependency as well:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150411/8a6fae94/attachment.sig>
