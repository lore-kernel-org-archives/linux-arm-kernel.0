From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 12:17:02 +0100
Subject: [PATCH] ALSA: ASoC: uda134x: fix codec driver
In-Reply-To: <E1V4712-0007sg-Dw@rmk-PC.arm.linux.org.uk>
References: <E1V4712-0007sg-Dw@rmk-PC.arm.linux.org.uk>
Message-ID: <20130730111701.GN9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 11:18:52AM +0100, Russell King wrote:
> For some reason, the DAC/ADCs are not being powered up when I try and
> use the UDA1341 driver; this used to work.  Looking back in the git
> history, I don't see anything obvious which would cause this
> regression.

Applied, thanks.  I've applied it for v3.12 for now rather than v3.11
since it's a relatively large change but obviously it's a fix and the
driver doesn't work anyway without it so I'm likely to pull it over for
v3.11.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/424a021a/attachment.sig>
