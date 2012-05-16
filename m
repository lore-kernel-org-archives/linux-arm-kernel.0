From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 May 2012 15:56:03 +0200
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
In-Reply-To: <201205161054.15610.arnd@arndb.de>
References: <20120516185812.ce1ab57c3ec72445135a35fc@canb.auug.org.au>
 <201205161054.15610.arnd@arndb.de>
Message-ID: <4FB3B1F3.6080102@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 12:54 PM, Arnd Bergmann :
> On Wednesday 16 May 2012, Stephen Rothwell wrote:
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> arch/arm/boot/dts/at91sam9g20.dtsi between commit 7cb2e629a240 ("ARM:
>> AT91: Add ADC driver to the at91sam9g20 dtsi") from the staging tree and
>> commit 5b6089cb6f28 ("ARM: at91: add at91sam9260 DT support") from the
>> arm-soc tree.
>>
>> So, I didn't know what to do with this, so I used the arm-soc version of
>> this file (effectively throwing away the staging tree change).  Hints,
>> anyone?
> 
> I suspect the addition of the adc node should just go into the
> at91sam9260.dtsi file.

Well, not so sure...

Hi all,

I am on the subject till this morning to figure out if the parameters
are SoC dependent. It seems that the ADC is the same between those two
platforms but the technology is different: I have to figure out the
details internally.

I will give you a patch on top of arm-soc soon. It will replace the one
in staging-next: does it sound good to you?

Bye,
-- 
Nicolas Ferre
