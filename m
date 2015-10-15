From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Oct 2015 09:51:45 +0200
Subject: [PATCH v2 1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <561CEAB0.1070500@vollmann.ch> (Detlef Vollmann's message of
 "Tue, 13 Oct 2015 13:27:44 +0200")
References: <1443795153-40836-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <561CEAB0.1070500@vollmann.ch>
Message-ID: <87eggw36y6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Detlef,
 
 On mar., oct. 13 2015, Detlef Vollmann <dv@vollmann.ch> wrote:

> On 10/02/15 16:12, Andy Shevchenko wrote:
>> Instead of custom approach let's use generic helper function.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Detlef Vollmann <dv@vollmann.ch>
>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>


Applied on mvebu/soc

With the tested-by flag from Detlef

Thanks,

Gregory


>> ---
>> Changelog v2:
>> - select GENERIC_NET_UTILS when appropriate
>> - compile test only
>>   arch/arm/mach-orion5x/Kconfig        |  3 ++
>>   arch/arm/mach-orion5x/dns323-setup.c | 53 ++----------------------------------
>>   arch/arm/mach-orion5x/tsx09-common.c | 49 +++------------------------------
>>   3 files changed, 10 insertions(+), 95 deletions(-)
> At last I found some time to test it on DNS-323.
> Applied to Russell's tree and used orion5x_defconfig.
> Works nicely, and I like that the final (compressed) kernel
> binary is now 200 byte smaller!
>
> Sorry, can't test on a TS-x09.
>
> Thanks,
>   Detlef
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
