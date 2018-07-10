From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Jul 2018 07:42:58 -0700
Subject: [PATCH] MAINTAINERS: arm64: Remove boot/dts/ directory from arm64
 entry
In-Reply-To: <CAMuHMdUqRXde5DNgK6ih+ivuwY9HFbcWwbx_x3q5PmFcrGi0pQ@mail.gmail.com>
References: <1530879736-7650-1-git-send-email-will.deacon@arm.com>
 <CAMuHMdUqRXde5DNgK6ih+ivuwY9HFbcWwbx_x3q5PmFcrGi0pQ@mail.gmail.com>
Message-ID: <CAOesGMhpkNvWiaqG=6V6KSshGzwZeSZDF-+4H7JVZqykxR+04A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 10, 2018 at 12:25 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Will,
>
> On Fri, Jul 6, 2018 at 2:22 PM Will Deacon <will.deacon@arm.com> wrote:
>> The arm-soc tree does a good job handling .dts files, so exclude them
>> from the ARM64 entry in MAINTAINERS.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> Thanks for your patch!
>
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2264,6 +2264,7 @@ L:        linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>>  S:     Maintained
>>  F:     arch/arm64/
>> +X:     arch/arm64/boot/dts/
>>  F:     Documentation/arm64/
>
> Please note that this does not cause checkpatch to point to the arm-soc
> tree, but does drop the reference to linux-arm-kernel, which may not
> be intentional?

It is intentional. If people start sending patches to arm at kernel.org
we'll drown. The model relies on platform maintainers picking up the
contents and sending us pull requests.


-Olof
