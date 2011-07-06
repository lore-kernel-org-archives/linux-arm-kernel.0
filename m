From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jul 2011 22:02:48 +0800
Subject: [GIT PULL] pxa: fixing patches for v3.0-rc6
In-Reply-To: <201107061556.23356.arnd@arndb.de>
References: <CAMPhdO_6CqVn_SdX-tPBtmHjkKH6kiWzuRkCDWkxaCUacReQhg@mail.gmail.com>
	<201107061556.23356.arnd@arndb.de>
Message-ID: <CAMPhdO_krAn-tQYfwAh7a+Q+_xRU-DdwQn+gAi-LW3oFQauBmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 9:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 05 July 2011, Eric Miao wrote:
>> The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
>>
>> ? Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)
>>
>> are available in the git repository at:
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix
>>
>> Lei Wen (2):
>> ? ? ? ARM: pxa910: correct nand pmu setting
>> ? ? ? ARM: pxa168: correct nand pmu setting
>>
>> Paul Parsons (1):
>> ? ? ? ARM: pxa: fix PGSR register address calculation
>>
>
> Merged into arm/soc#pxa/fixes
>
> I'll wait a few days for other soc maintainers to send fixes and then
> send a consolidated pull request.
>
> I noticed that none of these have a cc:stable at kernel.org tag, but the
> code that you patch has been in the same state since 2009 or early 2010,
> respectively. Are you sure the fixes are not needed on older kernels?
>

They are. Can I do a rebase and send another git-pull?

> Thanks,
>
> ? ? ? ?Arnd
>
