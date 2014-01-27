From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 20:46:17 +0000
Subject: [PATCH RFC v3 3/8] ASoC: davinci-mcasp: Set BCLK divider if
 McASP is BCLK master
In-Reply-To: <27d041ee149081cd9b401939d4382e73fba5e7a5.1390836773.git.jsarha@ti.com>
References: <cover.1390836773.git.jsarha@ti.com>
 <27d041ee149081cd9b401939d4382e73fba5e7a5.1390836773.git.jsarha@ti.com>
Message-ID: <20140127204617.GA11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:37:52PM +0200, Jyri Sarha wrote:
> Make BCLK divider setting implicite in hw_params call if McASP device
> is the bit clock master on the audio serial bus.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/264185d7/attachment.sig>
