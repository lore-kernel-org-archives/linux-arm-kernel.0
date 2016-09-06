From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Sep 2016 11:30:16 +0100
Subject: [PATCH v2] ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle
In-Reply-To: <1473125035-74895-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1473125035-74895-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20160906103016.GI3950@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:23:55AM +0800, Sugar Zhang wrote:

>  	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
> -	int ret;
> +	int ret = 0;

Same here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/45d9141a/attachment.sig>
