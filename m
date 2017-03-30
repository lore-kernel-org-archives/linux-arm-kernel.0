From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 17:03:00 +0200
Subject: [GIT PULL] ARM: OXNAS SoC update for 4.12
In-Reply-To: <7432624.QZN9TsYLQF@wuerfel>
References: <cd2d94ef-9098-6e4e-ed65-74191d45370e@baylibre.com>
 <7432624.QZN9TsYLQF@wuerfel>
Message-ID: <CAK8P3a0uexaSYw_Wnim3-00=Zn8Bn85nfpTrKzgRoBY+NUhr+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, March 20, 2017 10:39:56 AM CEST Neil Armstrong wrote:
>> Dear arm-soc maintainers,
>>
>> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>>
>>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>>
>> are available in the git repository at:
>>
>>   https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-for-4.12
>>
>> for you to fetch changes up to b44327d198b4f1bbebaf83f714cde450471de644:
>>
>>   ARM: oxnas: remove redundant select CPU_V6K (2017-03-20 10:13:45 +0100)
>>
>> ----------------------------------------------------------------
>> - Fix OX820 Kconfig
>>
>
> I've merged this into next/fixes-non-critical. Thanks,

BTW, it took 20 minutes to pull this branch from github.com, possibly they
had moved this to cold storage. Are you able to migrate your git tree to
kernel.org or host it yourself on baylibre.com in the future?

It's not urgent, but the delay was rather annoying and I had already
given up and applied the patch manually when the pull finally succeeded.

       Arnd
