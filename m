From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 1 Oct 2010 19:39:44 +0900
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
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
	<AANLkTimPgPY9rX_MYZTv0PpRQgfWGoSeSE9WWy_ami-V@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69532DCF34AE@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <AANLkTi=+1y9Bok0xnFueSfRsQGwnDVmySNNbNjgY_AdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 1, 2010 at 5:46 PM, Arun MURTHY <arun.murthy@stericsson.com> wrote:
>> On Fri, Oct 1, 2010 at 4:25 PM, Arun MURTHY
>> <arun.murthy@stericsson.com> wrote:
>> > You can have a look at the pwm_config_nosleep(),pwm_set_polarity(),
>> > pwm_synchronize(),pwm_unsynchronize(), pwm_set_handler() etc.
>> > These are not being used by the exsting pwm drivers except Atmel pwm.
>> How would your 'simple' driver handle Atmel then ?
>> What if future's SoCs start providing those 'advance' features like
>> Atmel's ?
>>
> The pwm core driver is the intersection of all pwm drivers and not union
> of all pwm driver. I refer this as simple pwm core driver / framework.
> Atmel pwm is of a separate classification.
> It includes GPIO also. Though, Atmel can use the pwm core driver framework
> for functionalities like pwm_enable, pwm_disable, pwm_config, etc and remaining
> functionalities specific to Atmel will be handled in Atlmel pwm driver and
> will not be exposed to the entire kernel.
> Its that the present day pwm device that has been made easy though, by providing
> the same functionality.
It's sad that Bill Gatliff didn't/couldn't take his work to conclusive end.
The work was apparently better
http://www.mail-archive.com/linux-embedded at vger.kernel.org/msg02599.html

Best of luck.
