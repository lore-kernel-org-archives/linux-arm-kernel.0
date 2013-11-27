From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 27 Nov 2013 09:16:16 +0800
Subject: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
In-Reply-To: <20131126132244.GP14725@sirena.org.uk>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
 <20131126132244.GP14725@sirena.org.uk>
Message-ID: <529547E0.3060504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/26/2013 09:22 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 12:17:51PM +0800, Bo Shen wrote:
>
>> +	card->drvdata = priv;
>
> You should use snd_soc_card_set_drvdata() for this.

OK, I will change to use snd_soc_card_set_drvdata() for this.
Thanks.

Best Regards,
Bo Shen
