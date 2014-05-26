From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 May 2014 14:29:11 +0100
Subject: [PATCH] ASoC: max98090: Add NI/MI values for user pclk 19.2 MHz
In-Reply-To: <1400757703-24431-1-git-send-email-s.nawrocki@samsung.com>
References: <1400757703-24431-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140526132911.GX22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 01:21:43PM +0200, Sylwester Nawrocki wrote:
> From: Chen Zhen <zhen1.chen@samsung.com>
> 
> This patch adds the clock divisor and multiplier NI, MI values for audio
> sampling frequencies 44100 and 48000 Hz and PCLK 19.2 MHz. This is useful
> for the Odroid X2/U2 boards when the codec works in master mode and its
> MCLK clock is fed from the I2S CDCLK output.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/f5c26876/attachment.sig>
