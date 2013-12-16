From: jean.pihet@linaro.org (Jean Pihet)
Date: Mon, 16 Dec 2013 18:42:05 +0100
Subject: [PATCH 0/3] ARM64: add perf support
In-Reply-To: <20131216173214.GK20193@mudshark.cambridge.arm.com>
References: <1387212873-8248-1-git-send-email-jean.pihet@linaro.org>
 <20131216173214.GK20193@mudshark.cambridge.arm.com>
Message-ID: <CAFrcx1mUiQwgw_SCYPQrU4Jz90Zmp5_uR8HSBceDbEKSCxO1OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 16 December 2013 18:32, Will Deacon <will.deacon@arm.com> wrote:
> Jean,
>
> On Mon, Dec 16, 2013 at 04:54:30PM +0000, Jean Pihet wrote:
>> Add perf support for the AARCH64 architecture. This includes the
>> support for:
>
> To be fair, we do have perf support already. This is extending what we have
> by adding additional arch-specific stuff.
Ok I can change the descriptions accordingly.

>> - AARCH64 perf registers definition and hooks,
>> - compat mode registers use, i.e. profiling a 32-bit binary on
>>    a 64-bit system,
>> - unwinding using the dwarf information from the .debug_frame
>>    section of the ELF binary; only in 64-bit mode,
>> - unwinding using the frame pointer information; in 64-bit and
>>    compat modes.
>
> Why did you send out two copies of this series to different lists? Which one
> should I be looking at?
The two copies actually are the same patches. I just forgot the l-a-k
ML address first and so re-sent the series. Sorry about that ;-|

> /confused

Thx for looking at the series!

>
> Will

Jean
