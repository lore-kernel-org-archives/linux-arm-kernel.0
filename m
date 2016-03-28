From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Mar 2016 12:11:15 -0700
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
In-Reply-To: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <20160328191115.GE2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 11:42:05AM +0800, PC Liao wrote:

> +Optional properties:
> +- mediatek,rt5650_i2s: I2S mode of rt5650
> +  0: using I2S1 on rt5650 for record
> +  1: using I2S2 on rt5650 for record
> +

I would expect the machine driver to have a reference to the DAI that is
in use rather than a property like this.  This is the way pretty much
all DT based machine drivers work...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160328/d8c0dcc4/attachment-0001.sig>
