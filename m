From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 8 Nov 2013 18:27:09 +0100
Subject: [PATCH trivial] arm64: constify hwcap_str
In-Reply-To: <20131108171949.GD17212@arm.com>
References: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131107175010.GI13674@arm.com>
 <CAKv+Gu9zw-1p6q6vnQWi=ZU53V-oeN_-vDH5Jfo0XvnBjMqN2g@mail.gmail.com>
 <20131108143807.GB17212@arm.com>
 <CAKv+Gu_vvLmLxD_NfVzK16cRccXj9FOZwG39D39nqgedF3qVBA@mail.gmail.com>
 <20131108171949.GD17212@arm.com>
Message-ID: <CAKv+Gu-RviPV+ihFoO+g_QODQ8t+d=soyjnsW2jw1cgGrmzBwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2013 18:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Nov 08, 2013 at 05:14:16PM +0000, Ard Biesheuvel wrote:
>> On 8 November 2013 15:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Thu, Nov 07, 2013 at 06:53:06PM +0000, Ard Biesheuvel wrote:
>> It's a trivial fix, so why not apply it?
>
> So far my toolchain already places it in .rodata since there is no write
> to these pointers.
>

So the fix is even more trivial than I thought :-)

Cheers,
Ard.
