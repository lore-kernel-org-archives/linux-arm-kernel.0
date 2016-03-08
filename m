From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 8 Mar 2016 07:23:20 +0700
Subject: [PATCH v14 00/20] arm64 kexec kernel patches v14
In-Reply-To: <1457393737.3560.36.camel@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
 <56DDFFC4.1040206@codeaurora.org> <1457393737.3560.36.camel@infradead.org>
Message-ID: <56DE1B78.3000201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geoff,

On 03/08/2016 06:35 AM, Geoff Levand wrote:
> On Mon, 2016-03-07 at 15:25 -0700, Azriel Samson wrote:
>
>> kexec-tools is still passing "mem=" parameter to the crash dump
>> kernel
>> which causes it to crash with ACPI. You can revert commit "arm64:
>> kdump:
>> pass "mem=" parameter to a crash dump kernel" in kexec-tools.
>
> Takahiro, can you verify this?

I know what happened. You didn't merge my changes on kexec-tools correctly.
Once I'm ready for a clean code on top of your tree, I'll let you know.

-Takahiro AKASHI

>> Also, some version of the following patch from Pratyush is also still
>> needed:
>> https://github.com/pratyushanand/kexec-tools/commit/85f403cabb9ae0d7a
>> 37d1656a00fb609a9525086
>
> I added that in.

> -Geoff
>
