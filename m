From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:16:25 +0100
Subject: [PATCH v2 0/4] arm64: defconfig: enable additional led triggers
In-Reply-To: <CAHLCerN4sYpU7PJG7JLhAy644s3jz9KD_myKWfOoOkEResPu-Q@mail.gmail.com>
References: <cover.1509951550.git.amit.kucheria@linaro.org>
 <CAHLCerN4sYpU7PJG7JLhAy644s3jz9KD_myKWfOoOkEResPu-Q@mail.gmail.com>
Message-ID: <CAK8P3a0+4ACDucmNQ3OL_0UjJnK6d3JXOb6_z5jtMQ986uZkLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 9:57 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> (Adding Arnd)
>
> Now that the merge window rush has abated, can you please apply this
> trivial series?
>
> On Mon, Nov 6, 2017 at 12:38 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> This patchset enables the kernel panic and disk-activity trigger for LEDs
>> and then enables the panic trigger for three 96Boards - DB410c, Hikey and
>> Hikey960.
>>
>> DB410c and Hikey panic behaviour has been tested by triggering a panic
>> through /proc/sysrq-trigger, while Hikey960 is only compile-tested.

I applied all four now, but it would have been easier for me if you had either
sent them to the platform maintainers, or to arm at kernel.org.

      Arnd
