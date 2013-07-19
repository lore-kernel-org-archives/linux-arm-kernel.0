From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 19 Jul 2013 14:06:20 +0800
Subject: [alsa-devel] [PATCH] ASoC: atmel: add wm8904 based audio machine
 driver
In-Reply-To: <51E8A6EF.4040608@atmel.com>
References: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
 <20130718111709.GL22506@sirena.org.uk> <51E8A6EF.4040608@atmel.com>
Message-ID: <51E8D75C.7030707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 07/19/2013 10:39 AM, Bo Shen wrote:
>
>>> +#define MCLK_RATE 32768
>>> +
>>> +static struct clk *mclk;
>>
>> This should be in driver data for the board.  Shouldn't the clock be
>> referenced using the clock bindings?
>
> I will try to implement this in next version.

After check the clock implementation, we are on the way to common clock 
framework, so will do this after we fully transfer to common clock.

Best Regards,
Bo Shen
