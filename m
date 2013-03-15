From: cooloney@gmail.com (Bryan Wu)
Date: Fri, 15 Mar 2013 14:02:24 -0700
Subject: [PATCH v3 3/3] leds: leds-pwm: Defer led_pwm_set() if PWM can
 sleep
In-Reply-To: <51437FEA.20807@epfl.ch>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-4-git-send-email-florian.vaussard@epfl.ch>
 <20130130081728.GC13568@avionic-0098.mockup.avionic-design.de>
 <512E2F98.6070404@epfl.ch> <51347B06.8090604@epfl.ch>
 <20130304105806.GA28735@avionic-0098.mockup.avionic-design.de>
 <513EFE17.6030203@epfl.ch>
 <CAK5ve-+TfHmvx8fiim2yyZhKbhgieO-WDqd+HG7ViLm=Fk3zNA@mail.gmail.com>
 <20130315185953.GA11351@avionic-0098.mockup.avionic-design.de>
 <51437FEA.20807@epfl.ch>
Message-ID: <CAK5ve-+auZKGr30oyx3=0iE5zq526jks-vxW=47CDey_zZQoWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 1:09 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> Hi,
>
>
> On 03/15/2013 07:59 PM, Thierry Reding wrote:
>>>
>>>
>>> Hi Florian and Thierry,
>>>
>>> Sorry, guys. My bad! I'm using GMAIL filtering my emails. This email
>>> goes into my arm-linux mail list archive and I totally missed it.
>>>
>>> I can merge this patch into my for-next branch, but it will be in 3.10
>>> not 3.9-rcX.
>>>
>>> Or Thierry, can you merge that to 3.9-rcX through your tree with my Ack?
>>
>>
>> I think 3.10 would be fine. We missed the merge window on this one and
>> it isn't really a fix so it's a bit late for 3.9 now.
>>
>> If Florian really absolutely needs this it can probably be done, but if
>> he can wait another few weeks it's certainly worth taking it through
>> linux-next for a while just to be safe.
>>
>
> I agree, another few weeks is not a problem :) Bryan, I let you merge this,
> ok?
>

Cool, I merged it into my for-next branch and it will be in linux-next soon.

Thanks,
-Bryan
