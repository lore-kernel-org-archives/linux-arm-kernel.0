From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 04 Jul 2010 12:03:33 +0200
Subject: [PATCH 2/3] ASoC: Add SmartQ sound driver
In-Reply-To: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
References: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
Message-ID: <4C305C75.1060305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 03-07-10 02:46, Maurus Cuelenaere schreef:
> +static struct snd_soc_jack_pin smartq_jack_pins[] = {
> +	/* Disable speaker when headphone is plugged in */
> +	{
> +		.pin	= "Internal Speaker",
> +		.mask	= SND_JACK_HEADPHONE,
> +		.invert	= true,
> +	},
> +};

Hmm I just discovered that this .invert should be false (guess I didn't test enough), should I resubmit this patch or submit an incremental one?

-- 
Maurus Cuelenaere
