From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 23:13:59 +0100
Subject: [PATCH v2 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
In-Reply-To: <1399141819-23924-6-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <1399141819-23924-6-git-send-email-andrew@lunn.ch>
Message-ID: <20140520221359.GF12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 08:30:15PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.

This doesn't apply against current code, can you please check and
resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/45dca0a0/attachment.sig>
