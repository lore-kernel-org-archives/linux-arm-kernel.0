From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Feb 2015 23:33:02 +0900
Subject: [PATCH] regulator: rk808: Set the enable time for LDOs
In-Reply-To: <1424480018-29298-1-git-send-email-dianders@chromium.org>
References: <1424480018-29298-1-git-send-email-dianders@chromium.org>
Message-ID: <20150221143302.GS6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 04:53:38PM -0800, Doug Anderson wrote:
> The LDOs are documented in the rk808 datasheet to have a soft start
> time of 400us.  Add that to the driver.  If this time takes longer on
> a certain board the device tree should be able to override with
> "regulator-enable-ramp-delay".

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150221/9ddc4caa/attachment.sig>
