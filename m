From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 03 Jun 2018 00:27:58 +0200
Subject: [PATCH v8] ASoC: pxa: switch to new ac97 bus support
In-Reply-To: <20180602192930.17846-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Sat, 2 Jun 2018 21:29:30 +0200")
References: <20180602192930.17846-1-robert.jarzmik@free.fr>
Message-ID: <87fu24su1d.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
> snd_ac97 one.
> +	codecs_pdata = pdata ? pdata->codecs_pdata : NULL;

It's a shame my automated build and test system didn't catch that : it should
have been pdata->codec_pdata and not pdata->codecs_pdata.

Given that this slipped in, please don't apply this until I find out why my
builder lives in utopia.

Cheers.

--
Robert
