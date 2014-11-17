From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Nov 2014 14:52:30 +0000
Subject: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is
 disabled
In-Reply-To: <1416232589-31319-1-git-send-email-krishna.md@samsung.com>
References: <1416232589-31319-1-git-send-email-krishna.md@samsung.com>
Message-ID: <20141117145230.GD2722@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 07:26:29PM +0530, Krishna Mohan Dani wrote:
> Fixes the following compilation warning:
> Warning: 'rt5631_i2c_dt_ids' defined but not used - when DT is not used.
> 
> Signed-off-by: Claude Youn <claude.youn@gmail.com>
> Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>

Applied, thanks.  It's really weird that such a trivial patch would have
multiple authors, if you're forwarding on a patch from someone else
please preserve their authorship as well as signoff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/f5ad631d/attachment.sig>
