From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 23 Nov 2016 20:38:00 +0900
Subject: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
In-Reply-To: <20161122155759.GG10134@dell.home>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
 <20161122155759.GG10134@dell.home>
Message-ID: <bd4944d8-3cef-b3f7-4fba-6de590493047@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 12:57 AM, Lee Jones wrote:
>>  	pwrbutton {
>> > -		interrupts = <TPS65217_IRQ_PB>;
>> > +		interrupts = <TPS65217_IRQ_PUSHBUTTON>;
> Push button or power button?
>

According to the datasheet, push button interrupt is correct.

	http://www.ti.com/lit/ds/symlink/tps65217.pdf

This is used for a power button input in Beaglebone boards. In other 
words, the power button is one of push button usages.

So, I'd like to keep general name for the interrupt.

Best regards,
Milo
