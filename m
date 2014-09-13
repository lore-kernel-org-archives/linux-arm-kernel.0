From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:36:48 -0700
Subject: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
In-Reply-To: <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
 <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140913163648.GJ7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:
> As "hclk" is used for rockchip I2S controller, driver must to enable
> it in probe.

Applied, again this is a bug fix.  How did the original submission get
tested?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/1b8bb26c/attachment.sig>
