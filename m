From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Feb 2015 07:54:25 +0800
Subject: [PATCH 3/4] ASoC: samsung: MACH_SMDKC100 isn't supported anymore
In-Reply-To: <1421664165.9655.54.camel@x220>
References: <1421664165.9655.54.camel@x220>
Message-ID: <20150206235425.GQ31311@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 11:42:45AM +0100, Paul Bolle wrote:
> Commit b8529ec1c1b0 ("ARM: S5PC100: no more support S5PC100 SoC")
> removed Kconfig symbol MACH_SMDKC100. But there are still two references
> to that symbol left. These are now pointless. Remove them too.

This doesn't apply against current code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/90605da2/attachment.sig>
