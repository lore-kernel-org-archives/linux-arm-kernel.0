From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Sep 2014 09:45:50 -0700
Subject: [PATCH v2] ASoC: rockchip-i2s: dt: fix an error in the example
In-Reply-To: <1410665999-16718-1-git-send-email-jay.xu@rock-chips.com>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
 <1410665999-16718-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140915164550.GV7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 11:39:59AM +0800, Jianqun wrote:
> Reference to RK3288 TRM, fix an error in the example by swap "tx" and "rx".
> 
> Table 10-1 DMAC_BUS Request Mapping Table
> Req number	Source	Polarity
> 0		I2S tx	High level
> 1		I2S rx	High level
> 
> Tested on RK3288 board.
> 
> Signed-off-by: Jianqun <jay.xu@rock-chips.com>
> ---
> change since v1:
> - modify patch's changelog as Mark's suggestion

No, the patch has already been applied.  Once a patch has been applied
don't resend it, it can't be re-applied.  In this case the advice about
the changelog was something you should bear in mind for future
changelogs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/efad01ea/attachment.sig>
