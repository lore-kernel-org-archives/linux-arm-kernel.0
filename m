From: avifishman70@gmail.com (Avi Fishman)
Date: Tue, 13 Feb 2018 11:29:32 +0200
Subject: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com>
 <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
Message-ID: <CAKKbWA6Otc1ZO_yHpfhxPjbgvvn-QXcXG9sy5=3FZDY8d_20rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Feb 6, 2018 at 12:57 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>> Tested-by: Avi Fishman <avifishman70@gmail.com>
> ...
>> +               enable-method = "nuvoton,npcm7xx-smp";
>
> I see this has already been reviewed quite a bit, but I'm curious
> about the 'npcm7xx'
> part here. Shouldn't that be a real chip name rather than a wildcard?
>
>        Arnd

There is a family of npcm7xx, some with SMP and some without.
For those who has it, it is common for all to use the same
"nuvoton,npcm7xx-smp".

Avi
