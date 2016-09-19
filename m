From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Sep 2016 09:33:42 +0100
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <1474207751-9804-2-git-send-email-ayaka@soulik.info>
References: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
 <1474207751-9804-2-git-send-email-ayaka@soulik.info>
Message-ID: <20160919083342.GE10189@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 10:09:11PM +0800, Randy Li wrote:

> It is simple sound card time, we could assign different codec
> to a interface without making a specific driver for it.

>  config SND_SAMSUNG_AC97
> -	tristate
> +	tristate "Samsung AC97 controller support"
>  	select SND_SOC_AC97_BUS

Are you *sure* simple-card works for AC'97?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/3328cc74/attachment-0001.sig>
