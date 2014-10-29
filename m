From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Oct 2014 10:17:42 +0000
Subject: [PATCH] ASoC: rockchip-i2s: fix infinite loop in
 rockchip_snd_rxctrl
In-Reply-To: <1414575951-18015-1-git-send-email-jay.xu@rock-chips.com>
References: <1414575951-18015-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20141029101742.GV18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 05:45:51PM +0800, Jianqun wrote:
> We can get into an infinite loop if the I2S_CLR register fails to
> clear due to a missing break statement, so add that.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/6efdb59d/attachment.sig>
