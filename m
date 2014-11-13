From: krishna.md@samsung.com (D Krishna Mohan)
Date: Thu, 13 Nov 2014 15:45:57 +0530
Subject: [PATCH 2/4 V2] ASoC: Samsung: Add arndale_rt5631 machine driver
In-Reply-To: <20141112222902.GV3815@sirena.org.uk>
References: <1415781339-16089-1-git-send-email-krishna.md@samsung.com>
 <1415781339-16089-3-git-send-email-krishna.md@samsung.com>
 <20141112222902.GV3815@sirena.org.uk>
Message-ID: <A1C3160B59C9424AB8F073F7A67DB325@sisodomain.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--------------------------------------------------
From: "Mark Brown" <broonie@kernel.org>
Sent: Thursday, November 13, 2014 3:59 AM
To: "Krishna Mohan Dani" <krishna.md@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>; 
<linux-arm-kernel@lists.infradead.org>; <alsa-devel@alsa-project.org>; 
<kgene.kim@samsung.com>
Subject: Re: [PATCH 2/4 V2] ASoC: Samsung: Add arndale_rt5631 machine driver


>> +static struct snd_soc_card arndale = {
>> +	.name = "Arndale-I2S",
>> +	.dai_link = arndale_dai,
>> +	.num_links = ARRAY_SIZE(arndale_dai),
>> +};

>Please give the card a more specific name like "Arndale RT5631" and
>similarly update the symbol names, there are other modules for the
>Arndale board.

Ok I changed the name from "Arndale-I2S" to "Arndale-RT5631".
>From the rest of the comment what I understand is you want me to change the 
names of struct snd_soc_dai_link and struct snd_soc_card.
Am that right? and/or do you want me to change the names whereever it sounds 
like generic and make it specific for arndale - rt5631 pair?
 
