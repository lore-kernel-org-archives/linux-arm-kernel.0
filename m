From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 18:33:31 +0100
Subject: [PATCHv1 6/8] ASoC: fsl: add SGT15000 based audio machine driver.
In-Reply-To: <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131018173331.GV2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:01:15PM +0800, Xiubo Li wrote:

> +	ret = snd_soc_register_card(&fsl_sgt1500_card);
> +	if (ret) {
> +		dev_err(&pdev->dev, "register soc sound card failed :%d\n",
> +				ret);
> +		return ret;
> +	}

Use the newly added devm_snd_soc_register_card() (in -next).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/53814d31/attachment.sig>
