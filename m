From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 7 Aug 2013 10:20:20 +0200
Subject: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
In-Reply-To: <20130806171156.GN6427@sirena.org.uk>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
 <20130806171156.GN6427@sirena.org.uk>
Message-ID: <CACQ1gAhVfSV1MArzTGxSfJOcEksBv-O2AjVJm6eEoBGtggw5uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/6 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 30, 2013 at 12:32:03PM +0200, Richard Genoud wrote:
>> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Description of the Asoc machine driver for an at91sam9x5 based board
>> with a wm8731 audio DAC. Wm8731 is clocked by a crystal and used as a
>> master on the SSC/I2S interface. Its connections are a headphone jack
>> and an Line input jack.
>
> Applied, thanks.  We should really be able to merge this with the
> sam9g20ek driver that's here already but we can do that later.

I think it will be easier after the switch to the common clock framework.
I'll look into that.

Thanks !
