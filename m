From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Mar 2017 19:06:43 +0000
Subject: [PATCH] arm64: Revert "arm64: kaslr: fix breakage with
 CONFIG_MODVERSIONS=y"
In-Reply-To: <20170206190337.GD20777@arm.com>
References: <1486393362-10875-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170206190337.GD20777@arm.com>
Message-ID: <CAKv+Gu_-GS=Paq=Ln21yzh4VW0MzD6ESW1OF3LKhugVwKH0DQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2017 at 19:03, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Feb 06, 2017 at 03:02:42PM +0000, Ard Biesheuvel wrote:
>> This reverts commit 9c0e83c371cf4696926c95f9c8c77cd6ea803426, which
>> is no longer needed now that the modversions code plays nice with
>> relocatable PIE kernels.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> This simply removes some dead code, so this patch can wait for v4.12 if
>> preferred. (The modversions fixes were only queued for -rc7)
>
> Yeah, probably best to leave this one until 4.12 given that for-next/core
> is based on -rc3.
>

I think this is good to go now
