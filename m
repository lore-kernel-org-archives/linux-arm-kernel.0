From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 31 Dec 2014 22:52:38 +0800
Subject: [PATCH 4/4] ARM: sirf: bring up SMP in atlas7 SoC
In-Reply-To: <1704317.ZimINfER0N@wuerfel>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <1419496460-4929-5-git-send-email-21cnbao@gmail.com>
 <1704317.ZimINfER0N@wuerfel>
Message-ID: <CAGsJ_4wAs3G274wPN6pDmv0YcVo7YTjydVZWWMERpstCP-GMKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-31 6:38 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 25 December 2014 16:34:20 Barry Song wrote:
>> From: Zhiwu Song <Zhiwu.Song@csr.com>
>>
>> correct cpu1 jump/flag address, remove scu related logic, scu doesn't
>> expose in cortex-a7.
>>
>> this patch breaks marco chip, but marco project has been dropped.
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> It doesn't seem nice to intentionally break hardware that we still have
> support for in the kernel. If Marco is not used anywhere, how about
> sending another patch before this one to remove all references to it?

it is ok. we can drop the MARCO machine and related configurations.
>
>         Arnd

-barry
