From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 1 Oct 2010 16:42:48 +0900
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<4CA1AD2B.8000905@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
	<4CA1BC16.3020702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
	<4CA25841.4090702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69532DCF32BC@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTikTo42Q5-yMEwyQH4mt=qLjaKrtJK3ydZNFyqai@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69532DCF33BB@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY <arun.murthy@stericsson.com> wrote:
> You can have a look at the pwm_config_nosleep(),pwm_set_polarity(),
> pwm_synchronize(),pwm_unsynchronize(), pwm_set_handler() etc.
> These are not being used by the exsting pwm drivers except Atmel pwm.
How would your 'simple' driver handle Atmel then ?
What if future's SoCs start providing those 'advance' features like Atmel's ?

> I mean not the functions but the functionality.
> PWM is a simple device and most of its clients are controlling intensity
> of backlight, leds, vibrator etc.
> I don't think these complex functionality are required.
oh dear !
