From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Feb 2015 07:54:57 +0800
Subject: [PATCH 4/4] ASoC: samsung: remove outdated Kconfig references
In-Reply-To: <1421664182.9655.55.camel@x220>
References: <1421664182.9655.55.camel@x220>
Message-ID: <20150206235457.GR31311@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:43:02AM +0100, Paul Bolle wrote:
> The Kconfig symbols MACH_SMDKC110 and MACH_SMDKV210 were removed in
> v3.17. But the Kconfig entries for SND_SOC_SAMSUNG_SMDK_WM8580 and
> SND_SOC_SAMSUNG_SMDK_WM9713 still reference them.

This doesn't apply against current code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/54eb72f6/attachment.sig>
