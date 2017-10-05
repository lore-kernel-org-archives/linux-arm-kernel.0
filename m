From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Oct 2017 22:29:47 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: fix non-SMP build
In-Reply-To: <CAMuHMdXjD-MpW9sqKtdUasizN8YkWuzChNyduyHz7p-cz38VBg@mail.gmail.com>
References: <20171005120914.465582-1-arnd@arndb.de>
 <CAMuHMdXjD-MpW9sqKtdUasizN8YkWuzChNyduyHz7p-cz38VBg@mail.gmail.com>
Message-ID: <CAK8P3a1BkwquyVgRAsRgt2d5jv7TGoKPhA_gA0p+UQ9Spu_g2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 2:25 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 5, 2017 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>  arch/arm/mach-shmobile/headsmp-apmu.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
>> index db4743d2bf91..5672b5849401 100644
>> --- a/arch/arm/mach-shmobile/headsmp-apmu.S
>> +++ b/arch/arm/mach-shmobile/headsmp-apmu.S
>
> As this hasn't been pulled into arm-soc yet (pull request sent though),
> perhaps Simon should squash this fix into the original commit?
> Should we rename headsmp-apmu.S to head-apmu.S?

I'm fine with it either way, just do whatever works best for you here.

     Arnd
