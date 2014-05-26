From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 May 2014 14:29:46 +0100
Subject: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
In-Reply-To: <1400772710-23523-1-git-send-email-andrew@lunn.ch>
References: <20140520221359.GF12304@sirena.org.uk>
 <1400772710-23523-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140526132945.GY22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 05:31:49PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/5a890b51/attachment.sig>
