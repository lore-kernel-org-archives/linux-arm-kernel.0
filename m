From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Nov 2014 15:56:26 +0000
Subject: [PATCHv2] ASoC: cs42l51: re-hook of_match_table pointer
In-Reply-To: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141112155626.GN3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 03:40:44PM +0100, Thomas Petazzoni wrote:
> In commit a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver"),
> the I2C part of the CS42L51 was moved to a separate file, but the

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/f9151867/attachment-0001.sig>
