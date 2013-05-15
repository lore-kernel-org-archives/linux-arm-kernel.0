From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 May 2013 08:59:42 +0400
Subject: [PATCH] ASoC: remove saarb and tavorevb3 machine drivers
In-Reply-To: <1368544041.1350.111.camel@x61.thuisdomein>
References: <1368544041.1350.111.camel@x61.thuisdomein>
Message-ID: <20130515045942.GK24524@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 05:07:21PM +0200, Paul Bolle wrote:
> Support for PXA95x was removed in v3.8. This means that the Kconfig
> symbols MACH_SAARB and MACH_TAVOREVB3 are no longer available. This
> leaves the SoC Audio support for Marvell Saarb and Marvell Tavor EVB3
> unbuildable. Remove these drivers too.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130515/7030a07d/attachment.sig>
