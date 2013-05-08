From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 May 2013 11:57:32 +0100
Subject: [PATCH] ARM: ux500: update MSP1 pinctrl defintions
In-Reply-To: <1368004193-21213-1-git-send-email-fabio.baltieri@linaro.org>
References: <1368004193-21213-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130508105732.GD7478@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 11:09:53AM +0200, Fabio Baltieri wrote:
> Update MSP1 pinctrl definitions in mop500_family_pinmap by removing
> sleep state and setting default ones as pin hogs, as those are used by
> both ux500-msp-i2s.1 and ux500-msp-i2s.3.

This presumably needs to go along with the ASoC side of this change but
as I said in reply to that this isn't an obvious improvement.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130508/9ded3701/attachment.sig>
