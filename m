From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:38:24 -0700
Subject: [PATCH 1/5] ASoC: rockchip-i2s: fix rockchip i2s defination more
 reasonable
In-Reply-To: <1410568819-21671-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568819-21671-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140913163824.GL7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 08:40:19AM +0800, Jianqun wrote:
> Fix SND_ROCKCHIP_I2S to be more reasonable - SND_SOC_ROCKCHIP_I2S,
> SND_SOC_ROCKCHIP_I2S should select by audio driver, instead of
> SND_SOC_ROCKCHIP.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/66e7aad2/attachment.sig>
