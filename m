From: brian.austin@cirrus.com (Brian Austin)
Date: Tue, 28 Oct 2014 14:50:32 -0500
Subject: [PATCH 2/6] ASoC: cs42l51: make driver user-selectable
In-Reply-To: <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1410281449130.28816@heelrod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> the CS42L51 I2C codec driver user-selectable.
> 
> Cc: Brian Austin <brian.austin@cirrus.com>
> Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  sound/soc/codecs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index a68d173..f4fb12f 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -336,7 +336,7 @@ config SND_SOC_CS42L51
>  	tristate
>  
>  config SND_SOC_CS42L51_I2C
> -	tristate
> +	tristate "Cirrus Logic CS42L51 CODEC (I2C)"
>  	select SND_SOC_CS42L51
>  
>  config SND_SOC_CS42L52
> -- 
> 2.0.0
> 

Thanks,

Acked-by: Brian Austin <brian.austin@cirrus.com>
