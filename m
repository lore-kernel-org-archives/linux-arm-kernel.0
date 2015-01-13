From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 13 Jan 2015 22:26:44 +0800
Subject: [GIT PULL] CSR atlas7 init dts for 3.20
In-Reply-To: <CAGsJ_4x35UqL65_NYzdTp=YOu5mUuSxHaVEXG6ArsKfvQEqOAw@mail.gmail.com>
References: <CAGsJ_4wBEmLa8t-bVBQTBhJDHSU=-ciycpAnH4arWPNUq-tHWA@mail.gmail.com>
 <20150113021347.GD28758@quad.lixom.net>
 <CAGsJ_4x35UqL65_NYzdTp=YOu5mUuSxHaVEXG6ArsKfvQEqOAw@mail.gmail.com>
Message-ID: <CAGsJ_4yKaKRTAdA8RthPo5dEBBoy6dp5Xf-P9+A4Omo+eOL=Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-13 10:22 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> 2015-01-13 10:13 GMT+08:00 Olof Johansson <olof@lixom.net>:
>> On Sun, Jan 11, 2015 at 10:51:40PM +0800, Barry Song wrote:
>>> Hi Arnd, Kevin, Olof,
>>>
>>> The following changes since commit b7392d2247cfe6771f95d256374f1a8e6a6f48d6:
>>>
>>>   Linux 3.19-rc2 (2014-12-28 16:49:37 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>> for you to fetch changes up to e57574b88f1d29de0b0e9a3a994cd60c8b800253:
>>>
>>>   ARM: dts: add init dts file for CSR atlas7 SoC (2015-01-11 22:39:10 +0800)
>>>
>>> ----------------------------------------------------------------
>>> drop marco and add init dts for atlas7
>>>
>>> marco chip has been dropped and the new replacement is atlas7.
>>> so, drop marco dts, and add dts for atlas7.
>>
>> Hi,
>>
>> Can you please elaborate a bit. Was marco never shipped to customers
>> that could be interested in mainline support, and atlas7 is a replacement
>> SoC that is in development or has shipped?
>>
>
> marco never shipped to customers that could be interested in mainline support.
> atlas7 is a replacement SoC that is in development.
>
> do you mean i need to put this into tag log?

Hi Olof, i did a refine for this tag according to your suggestion, see:
https://git.kernel.org/cgit/linux/kernel/git/baohua/linux.git/tag/?id=atlas7-init-dts-for-3.20

>
>>
>> Thanks,
>>
>> -Olof
>

-barry
