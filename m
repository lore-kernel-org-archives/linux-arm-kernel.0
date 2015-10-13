From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 13 Oct 2015 22:32:55 +0200
Subject: [PATCH v4 22/26] ARM: pxa: magician: Remove pdata for pasic3-leds
In-Reply-To: <1443877198.4186.40.camel@gmail.com> (Philipp Zabel's message of
 "Sat, 03 Oct 2015 14:59:58 +0200")
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B3A7.3090701@tul.cz>
 <1443877198.4186.40.camel@gmail.com>
Message-ID: <87bnc24ih4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> Am Montag, den 28.09.2015, 23:39 +0200 schrieb Petr Cvek:
>> The pasic3-leds driver was never in vanilla kernel. Actual
>> configuration
>> data for a hypothetical driver does not describe hardware completely,
>> so
>> remove them.
>> 
>> This patch prepare HTC Magician machine code to pasic3-leds driver
>> addition.
>> 
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>
> I had never figured out completely how the PASIC3 led blinking
> machinery works. If these LED descriptions are insufficient,
>
> Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
Queued into pxa/for-next, thanks.

Cheers.

-- 
Robert
