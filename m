From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 21 Jan 2016 17:18:07 +0100
Subject: [PATCH v3 0/7] ARM: dts: kirkwood: fixes and split of linkstation
 dts for ls-wvl/vl and ls-wxl/wsxl
In-Reply-To: <CAEQ9gEkVXWr2cvMVqp+9=J+F3iuer0eygnb_LkDAdAOPz55Bmw@mail.gmail.com>
 (Roger Shimizu's message of "Fri, 22 Jan 2016 01:05:28 +0900")
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
 <87d1suhqh8.fsf@free-electrons.com>
 <CAEQ9gEkVXWr2cvMVqp+9=J+F3iuer0eygnb_LkDAdAOPz55Bmw@mail.gmail.com>
Message-ID: <878u3ihpog.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,
 
 On jeu., janv. 21 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:

> On Fri, Jan 22, 2016 at 1:00 AM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> Hi Roger,
>>
>>  On jeu., janv. 21 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:
>>
>>> Dear kirkwood maintainers,
>>>
>>> Linkstation dts for ls-wxl and ls-wvl need some fixes:
>>>   - [patch 1/7] and [patch 2/7] are fixes for gpio pin
>>>   - [patch 3/7] and [patch 4/7] are fixes for gpio led
>>> Above 4 patches can be safely backported to 4.3/4.4 stable kernel.
>>>
>>> And in order to support more buffalo linkstation devices in convenient way,
>>> I split current 2 dts files into a few comoon dtsi files and device specific
>>> dts files.
>>>   - [patch 5/7] relicense dts under GPLv2/X11
>>>   - [patch 6/7] split dts for lswxl
>>>   - [patch 7/7] split dts for lswvl
>>>
>>> Changes in v2:
>>>   - separate the fix and relicense patch
>>>   - add "linkstation:" to all led labels
>>> Changes in v3:
>>>   - address Andrew Lunn's suggestion to change commit message
>>>     for [patch 3/7] and [patch 4/7]
>>>   - add Andrew Lunn's "Reviewed-by"
>>>   - address active high/low for the power LED
>>
>> I will apply this series on the mvebu branches when v4.5-rc1 will be
>> released (so it should be the next week).
>
> Dear Gregory,
>
> Thanks for your feedback!
>
> Just curious,
> since patch 0001~0004 are fixes, could it be applied earlier?

Our branches go to Linus tree through the arm-soc tree. As they have
just did a pull request I doubt a new one will be done this week.

Moreover all our patches are based on the rc1: having a single refrence
helps the arm-soc subsystem to merge all the contributions, that's why I
am waiting for next week.

And finally for this patch it is obviously too late for for 4.4 but we
have plenty of time for 4.5. However, I plan to send these fixes to
arm-soc early next week so it should be in 4.5-rc2, and as soon it will
be in Linus tree then it should be backported to 4.4 and 4.3 by the
stable team.

Gregory

>
> Cheers,
> Roger

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
