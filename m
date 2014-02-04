From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 18:12:13 +0000
Subject: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the
 tda998x CODEC
In-Reply-To: <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
References: <cover.1391274627.git.moinejf@free.fr>
 <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
Message-ID: <20140204181213.GO22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 01, 2014 at 05:48:49PM +0100, Jean-Francois Moine wrote:

> +	- compatible: must be "nxp,tda998x-codec".

It's not clear to me why there's a separate compatible here - as far as
I can see this can only appear as part of one of these devices and
there's no addressing or other information that'd account for chip
variation so I'd not expect to need to bind this independently of the
parent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/fbac5b49/attachment.sig>
