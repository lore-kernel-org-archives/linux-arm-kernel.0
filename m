From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 17 May 2013 05:18:33 +0200
Subject: GPIO sysfs : set a wake source
In-Reply-To: <51953840.9050106@wwwdotorg.org> (Stephen Warren's message of
 "Thu, 16 May 2013 13:49:20 -0600")
References: <87fvxwia0s.fsf@free.fr>
 <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
 <51926177.1050600@wwwdotorg.org> <87ip2ig1ez.fsf@free.fr>
 <51953840.9050106@wwwdotorg.org>
Message-ID: <87ehd6fg52.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

>>>> Instead figure out how to make the subsystems we have and the
>>>> device trees express what you want to do.
>>
>> As I said above, I don't think it's the way to go. I have *no* subsystem to
>> address.
>> Devicetree can't help in the toggle to "activate" or "deactivate" the wakeup
>> upon this GPIO, can it ?
>
> This sounds very similar to WiFi rfkill, although it's a MODEM not WiFi.
Mmmm yes, similar. But with one big difference : RFKill is control of wireless
chip "up state", while the toggle I'm speaking of will purely say if the "input
GPIO" will trigger a wake-up from S3 or not.

If RFKill interface had a toggle to say "hardware rfkill button toggle can
wake-up the kernel out of S3" then it would be very similar.

Cheers.

-- 
Robert
