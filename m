From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 18:25:56 +0100
Subject: [PATCH v5 05/12] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <CAPDyKFo-hpLd3W0zWykdg0swuciBeL=Cy9cur_0RoG8jApOh3w@mail.gmail.com>
 (Ulf Hansson's message of "Fri, 27 Jan 2017 16:36:36 +0100")
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <89c95d0084da6ad7132caa54ca66eb619d8a5090.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrCxk37uVZ4wM-=iwX3-Cn9j+uh1KneJoopVzia2nKTVA@mail.gmail.com>
 <87fuk4yg1i.fsf@free-electrons.com>
 <CAPDyKFo-hpLd3W0zWykdg0swuciBeL=Cy9cur_0RoG8jApOh3w@mail.gmail.com>
Message-ID: <87bmuswh23.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,
 
 On ven., janv. 27 2017, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>>
>> But I am curious to know why do you think we could use it without any
>> need. Are you aware of some abuse of this property?
>
> Yes.
>

Actually I was hopping that you point some examples :)

But as you point mmc-ddr-3_3v I found my answers here:
http://www.spinics.net/lists/linux-mmc/msg38602.html

>>
>>>
>>> Perhaps you can elaborate exactly why it makes sense for your case. Or
>>> perhaps we already discussed this, in either case, please re-fresh my
>>> mind.
>>
>> For instance we need it now on the 7040DB board which does not have the
>> 1.8V signal voltage available.
>
> It it's better to describe what the controller/board support, instead
> of what it doesn't.
>
> I think you should be able to use other existing mmc DT bindings
> (perhaps also you need the brand new "mmc-ddr-3_3v"), instead of the
> "no-1-8-v".

OK I will try with this one. And if it works, I wonder if it worth
mentioning it as it is also part of the mmc binding.

Gregory

>
> Kind regards
> Uffe

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
