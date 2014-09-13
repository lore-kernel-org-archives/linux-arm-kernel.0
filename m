From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:40:32 -0700
Subject: [PATCH] ASoC: rockchip-i2s: dt: swap tx and rx channed request
 number
In-Reply-To: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140913164032.GN7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 09:04:41AM +0800, Jianqun wrote:
> Reference to RK3288 TRM, fix an error channel id for i2s tx and rx
> Table 10-1 DMAC_BUS Request Mapping Table
> Req number	Source	Polarity
> 0		I2S tx	High level
> 1		I2S rx	High level

Applied, thanks.  The changelog should've just noted that this is an
error in the example rather than the code or the binding, I was a bit
confused about this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/cbda250e/attachment-0001.sig>
