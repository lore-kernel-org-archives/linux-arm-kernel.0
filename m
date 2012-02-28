From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 Feb 2012 10:01:44 +0800
Subject: [GIT PULL] [for 3.4] git pull request for arch-pxa
In-Reply-To: <201202271516.40761.arnd@arndb.de>
References: <CAN1soZzkih_N9eB6+9F3j0QDbbhQ0wLMP2TkVoqMQ7UijEYCew@mail.gmail.com>
 <201202271516.40761.arnd@arndb.de>
Message-ID: <CAN1soZyDoyOJELwYScEw=B+UFboA7SnvxC8DtcNyRF-2_tvwQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 11:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 27 February 2012, Haojian Zhuang wrote:
>> Please help to pull these patches for v3.4.
>>
>> The following changes since commit c38e23456278e967f094b08247ffc3711b1029b2:
>>
>> ? i387: fix sense of sanity check (2012-02-15 08:05:18 -0800)
>>
>> are available in the git repository at:
>> ? git://github.com/hzhuang1/linux.git for-next
>>
>> Haojian Zhuang (7):
>> ? ? ? rtc: sa1100: remove periodic code
>> ? ? ? rtc: sa1100: remove verification code of alarm
>> ? ? ? rtc: sa1100: declare irq in resource
>> ? ? ? ARM: pxa: add rtc dummy clock
>> ? ? ? rtc: sa1100: enable clk support
>> ? ? ? ARM: mmp: enable rtc in pxa910
>> ? ? ? ARM: mmp: append irq name of gpio device
>>
>> Jett.Zhou (1):
>> ? ? ? ARM: sa1100: clean up clock support
>>
>> Paul Parsons (4):
>> ? ? ? pxa/hx4700: Correct StrataFlash block size discovery
>> ? ? ? pxa/hx4700: Add ASIC3 LED support
>> ? ? ? pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
>> ? ? ? pxa/hx4700: Fix basic suspend/resume
>
> Hi Haojian,
>
> Please follow the same rules for arm-soc pull requests as everyone
> else. In particular, don't rebase your patches on a random changeset
> for Linus but use an -rc tag as the base isntead, and split your
> patches into topic branches:
>
> The rtc changes clearly belong into one branch, while the cleanup
> and hx4700 changes do not. I would suggest sending three pull
> requests, one for cleanup, rtc and board specific changes.
> Ideally, the first two patches from the rtc series ("remove periodic
> code" and "remove verification code of alarm") would be in both
> the rtc series and the cleanup branch.
>
> ? ? ? ?Arnd

Sure. I'll do it now.

Best Regards
Haojian
