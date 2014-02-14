From: keescook@chromium.org (Kees Cook)
Date: Fri, 14 Feb 2014 11:13:53 -0800
Subject: [PATCH v3] ARM: mm: report both sections from PMD
In-Reply-To: <20140214101724.GC10590@arm.com>
References: <20140213195230.GA15275@www.outflux.net>
 <20140214101724.GC10590@arm.com>
Message-ID: <CAGXu5jKYq=0Ud-A6bdD2zMe=+r0S7nja8Rg+OxeT+JHzdpwTKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 2:17 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Feb 13, 2014 at 07:52:30PM +0000, Kees Cook wrote:
>> On 2-level page table systems, the PMD has 2 section entries. Report
>> these, otherwise ARM_PTDUMP will miss reporting permission changes on
>> odd section boundaries.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

On Fri, Feb 14, 2014 at 9:05 AM, Steve Capper <steve.capper@linaro.org> wrote:
> Tested-by: Steve Capper <steve.capper@linaro.org>

Thanks to both of you! If you have a moment can you check this other
patch which has additional fixes for the dump code?

https://lkml.org/lkml/2014/2/12/662

Thanks,

-Kees

-- 
Kees Cook
Chrome OS Security
