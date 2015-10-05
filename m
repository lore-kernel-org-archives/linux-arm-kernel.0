From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Oct 2015 14:22:20 +0100
Subject: [PATCH 09/15] arm64: Add page size to the kernel image header
In-Reply-To: <561274C8.20500@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-10-git-send-email-suzuki.poulose@arm.com>
 <20151002154900.GN6963@e104818-lin.cambridge.arm.com>
 <561274C8.20500@arm.com>
Message-ID: <CAKv+Gu9KAJMeVK257qPoWOvtvioj2qi9_Dqb--Gqo07fzhzKDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2015 at 14:02, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 02/10/15 16:49, Catalin Marinas wrote:
>>
>> On Tue, Sep 15, 2015 at 04:41:18PM +0100, Suzuki K. Poulose wrote:
>>>
>>> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>
>>> This patch adds the page size to the arm64 kernel image header
>>> so that one can infer the PAGESIZE used by the kernel. This will
>>> be helpful to diagnose failures to boot the kernel with page size
>>> not supported by the CPU.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>>
>> This patch needs you signed-off-by as well since you are posting it. And
>> IIRC I acked it as well, I'll check.
>>
>
> Yes, you did mention that you were OK with the patch. But I thought there
> was
> no  'Acked-by' tag added. Hence didn't pick that up.
>

In my version of this patch (which I sent separately before noticing
that Suzuki had already folded it into his series), I took the comment
from Catalin to the email in which I suggested this change as an
implicit Acked-by.

-- 
Ard.
