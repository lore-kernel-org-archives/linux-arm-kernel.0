From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 7 May 2014 11:52:05 +0200
Subject: [PATCH 3/3] perf tools: Add libdw DWARF post unwind support for
 ARM
In-Reply-To: <20140506175616.GH13677@arm.com>
References: <1399389979-11279-1-git-send-email-jean.pihet@linaro.org>
 <1399389979-11279-4-git-send-email-jean.pihet@linaro.org>
 <20140506175616.GH13677@arm.com>
Message-ID: <CAFrcx1=aS+dmM05Zk_ioL_0vE+ot+9=LJ=WsmExRtDyZgMtetA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 May 2014 19:56, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 06, 2014 at 04:26:19PM +0100, Jean Pihet wrote:
>> Adding libdw DWARF post unwind support, which is part
>> of elfutils-devel/libdw-dev package from version 0.158.
>>
>> The new code is contained in unwin-libdw.c object, and
>> implements unwind__get_entries unwind interface function.
>
>   Reviewed-by: Will Deacon <will.deacon@arm.com>

Ok, thx!

Jiri, Arnaldo,
Can you take the series for ARM and ARM64?

Jean
>
> Will
