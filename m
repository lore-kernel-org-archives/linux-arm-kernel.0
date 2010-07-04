From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Jul 2010 22:01:33 +0900
Subject: [PATCH 2/3] ASoC: Add SmartQ sound driver
In-Reply-To: <4C305C75.1060305@gmail.com>
	(sfid-20100704_110339_786796_2EEE3A65)
References: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
	<4C305C75.1060305@gmail.com> (sfid-20100704_110339_786796_2EEE3A65)
Message-ID: <F182A883-DE14-4BE4-8430-9C925E59893B@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 Jul 2010, at 19:03, Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:

> Op 03-07-10 02:46, Maurus Cuelenaere schreef:
>> +static struct snd_soc_jack_pin smartq_jack_pins[] = {
>> +	/* Disable speaker when headphone is plugged in */
>> +	{
>> +		.pin	= "Internal Speaker",
>> +		.mask	= SND_JACK_HEADPHONE,
>> +		.invert	= true,
>> +	},
>> +};
> 
> Hmm I just discovered that this .invert should be false (guess I didn't test enough), should I resubmit this patch or submit an incremental one?

Incremental please.
