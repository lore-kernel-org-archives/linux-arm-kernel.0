From: subaparts@yandex.ru (Alexander)
Date: Thu, 09 Dec 2010 01:59:26 +0300
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <20101208130558.GE16418@rakim.wolfsonmicro.main>
References: <1291809772.31916.4.camel@r60e>
	<20101208130558.GE16418@rakim.wolfsonmicro.main>
Message-ID: <1291849166.31916.74.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Wed, 2010-12-08 at 13:05 +0000, Mark Brown wrote:
> > +static const char *cs4271_de_texts[] = {"None", "44.1KHz", "48KHz", "32KHz"};
> > +static const struct soc_enum cs4271_de_enum =
> > +	SOC_ENUM_SINGLE(CS4271_DACCTL, 4, 4, cs4271_de_texts);
> 
> Ideally the deemphasis would be managed based on the sample rate.
> 

I'm not sure if it's necessary feature at all. And the way it should be
managed is something unclear to me )

All other issues were corrected, the patch will follow soon...

Best regards,
	Alexander A. Sverdlin.
