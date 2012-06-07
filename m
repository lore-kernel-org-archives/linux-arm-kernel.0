From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Jun 2012 06:13:26 +0800
Subject: [PATCH v1 4/5] ASoC: add mmp brownstone support
In-Reply-To: <1338791851-21038-5-git-send-email-zhangfei.gao@marvell.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-5-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120607221325.GB14525@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 02:37:30PM +0800, Zhangfei Gao wrote:

One small thing here...

> +	ret = snd_soc_add_card_controls(dapm->card, brownstone_dapm_control,
> +				   ARRAY_SIZE(brownstone_dapm_control));
> +	if (ret < 0)
> +		return ret;

You can just set these up with the controls member of the card struct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120608/bdcc3c68/attachment.sig>
