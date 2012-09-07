From: gerg@snapgear.com (Greg Ungerer)
Date: Fri, 7 Sep 2012 15:42:28 +1000
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <201209031324.22877.arnd@arndb.de>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdab72Z86i21TNohS0YO=Bav7eQgHwQyXa0tXQB=0hhgAg@mail.gmail.com>
 <5044A954.4000706@snapgear.com> <201209031324.22877.arnd@arndb.de>
Message-ID: <50498944.2060009@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03/09/12 23:24, Arnd Bergmann wrote:
> On Monday 03 September 2012, Greg Ungerer wrote:
>>> I suspect
>>> some of these platforms may have more users than we
>>> believe.
>>
>> I know the guys at www.opengear.com are still building hardware around
>> the KS8695. And they update to modern kernels from time to time. So its
>> not completely obsolete yet. I have some SnapGear boards based around it
>> too, though they went out of production about 2 years ago.
>
> Ok, good to know. Maybe we can catch their interest with this mail thread
> here and get them to contribute upstream as well.

I have just posted a patch for the SnapGear boards. I had a bit of
info and some code for the OpenGear boards too, so I posted a patch
for some of them too.

Regards
Greg



-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
