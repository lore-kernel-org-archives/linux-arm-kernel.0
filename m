From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 12 Mar 2013 11:06:15 +0100
Subject: [PATCH v3 3/3] leds: leds-pwm: Defer led_pwm_set() if PWM can
 sleep
In-Reply-To: <20130304105806.GA28735@avionic-0098.mockup.avionic-design.de>
References: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
 <1359381659-24454-4-git-send-email-florian.vaussard@epfl.ch>
 <20130130081728.GC13568@avionic-0098.mockup.avionic-design.de>
 <512E2F98.6070404@epfl.ch> <51347B06.8090604@epfl.ch>
 <20130304105806.GA28735@avionic-0098.mockup.avionic-design.de>
Message-ID: <513EFE17.6030203@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

>>>>
>>>> Bryan, I assume that you'll be taking this? It doesn't apply cleanly to
>>>> my tree, probably because of Peter's recent changes that you took
>>>> through your tree and Florian based his patches on top of that. The
>>>> conflict resolution should be trivial, though.
>>>>
>>>
>>> It seems that this patch was not taken. Could you pull it, as the other
>>> part is already in linux-pwm? Or is there any show stopper?
>>>
>>
>> Ping? Who should merge this?
>
> I assume Bryan will take it through the LED tree? Patches 1 & 2 went
> into v3.9-rc1 through the PWM tree.
>

Ping ?

Florian
