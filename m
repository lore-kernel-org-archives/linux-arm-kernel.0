From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 11 Mar 2015 14:21:29 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <2353601.si5uCETVn2@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <6286151.8rcX893TN6@wuerfel>
 <CABxcv=mPVxW=BqL2PUL=AtS74kcqMG1yxC1WqMpxGiNOqGAnyQ@mail.gmail.com>
 <2353601.si5uCETVn2@wuerfel>
Message-ID: <CABxcv==yx3dy-beEF9cf1mKo1vjCh_LU6iLuvn1z-SKz9xG0qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 2:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 11 March 2015 14:07:11 Javier Martinez Canillas wrote:
>>
>> Right now it seems that all boards in mainline with a WiLink6 part are
>> using internal clocks. So as a first step I think that adding an
>> optional refclock-frequency and tcxoclock-frequency properties should
>> be enough.
>>
>> It would be good if the driver supports getting the refclock and
>> tcxoclock from an external provider in case a board gets these from
>> external clocks but that can be done as a followup if there are boards
>> in the future using that design.
>>
>> But please bear in mind that I'm not familiar with the clock handling
>> in WiLink6 since the WiLink8 part used in the IGEP boards does not
>> need these clocks and I only looked at Luciano's previous patches and
>> the WiLink today driver today. So it would be good if Eliad can double
>> check my assumptions to see if those are correct.
>
> Sounds good. I'd also be fine with not implementing the case for
> external clocks in the code until we need (and can test) it, but
> I think it should be specified in the binding from the start.
>

Agreed.

Best regards,
Javier
