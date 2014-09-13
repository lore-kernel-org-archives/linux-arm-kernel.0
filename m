From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:35:01 -0700
Subject: [PATCH 2/5] ASoC: rockchip-i2s: fix master mode set bit error
In-Reply-To: <1410568863-21723-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568863-21723-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140913163501.GH7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 08:41:03AM +0800, Jianqun wrote:
> Fix error format set to I2S master or slave mode.
> Test on RK3288 board with max98090.

Applied.  Since this is a bug fix it should be one of the first patches
in the series so that it can be sent to Linus as a fix, bug fixes should
go before any other patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/00a92d24/attachment.sig>
