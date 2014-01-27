From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 18:10:40 +0000
Subject: [PATCH RFC v3 2/8] ASoC: davinci-evm: Add named clock reference
 to DT bindings
In-Reply-To: <a16e2a877740942c1742ac0da403013c72ae3727.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
 <a16e2a877740942c1742ac0da403013c72ae3727.1390836773.git.jsarha@ti.com>
Message-ID: <20140127181040.GA11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:37:51PM +0200, Jyri Sarha wrote:
> The referenced clock is used to get codec clock rate and the clock is
> disabled and enabled in startup and shutdown snd_soc_ops call
> backs. The change is also documented in DT bindigs document.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/e1f5b58d/attachment.sig>
