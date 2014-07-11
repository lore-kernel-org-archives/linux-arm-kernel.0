From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Jul 2014 14:04:21 +0100
Subject: [PATCH] ASoC: samsung-i2s: Maintain CDCLK settings across
 i2s_{shutdown/startup}
In-Reply-To: <1405008673-15994-1-git-send-email-s.nawrocki@samsung.com>
References: <1405008673-15994-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140711130421.GR30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 06:11:13PM +0200, Sylwester Nawrocki wrote:
> Currently configuration of the CDCLK pad is being overwritten in
> the i2s_shutdown() callback in order to gate the SoC output clock.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/dd0f93e2/attachment-0001.sig>
