From: Claudiu.Beznea@microchip.com (Claudiu Beznea)
Date: Thu, 18 Jan 2018 11:11:16 +0200
Subject: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
In-Reply-To: <20180117231357.GC112833@google.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <20180112183512.GB102880@google.com>
 <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
 <CAHp75VcaFDEQ1cBzeU2eBj_vf19ok6EWLC07SOTQLRH8BQSbzA@mail.gmail.com>
 <9a130c0b-572d-be0b-8ac7-596714208d41@microchip.com>
 <20180117231357.GC112833@google.com>
Message-ID: <b928d56f-8eb6-c23e-99bd-c4089e80f923@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18.01.2018 01:14, Brian Norris wrote:
> On Tue, Jan 16, 2018 at 10:24:59AM +0200, Claudiu Beznea wrote:
>> Please explain me further. From this I understand, as a general rule,
>> that the device tree binaries from, e.g. 3 years ago, should be
>> compatible with, e.g. the current version of kernel?
> 
> Yes.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/ABI.txt
> 
I agree, I found that after some research.

Thanks,
Claudiu
