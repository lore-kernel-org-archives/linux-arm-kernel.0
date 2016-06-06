From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 00:50:26 +0100
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <5751912C.6080904@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
Message-ID: <20160606235026.GP7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:16:12PM +0800, Xing Zheng wrote:

> I refered to MTK's mt8173-rt5650-rt5514.txt on upstream, that compatible
> name is "mediatek,mt8173-rt5650-rt5514".
> Because our platform need to support 3 codecs (max98357a / da7219 / rt5514).
> Perhaps, you maybe feel that name is too long? And, could you please tell me
> what names would be better?

> For example: "rk3399-composite-codecs" ?

It should probably be three compatibles, one per CODEC, if the driver
needs to handle each separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/8cbdc154/attachment.sig>
