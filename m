From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 30 Oct 2015 13:17:24 +0100
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <562F8DCE.4010308@arm.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <562EA894.8070505@arm.com> <562EAA22.3010905@arm.com>
 <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
 <562F8DCE.4010308@arm.com>
Message-ID: <CAKv+Gu-m7dJbiF=8i=+cN=bx+y8AKu_MgHrS29jNK0fTvuwQ5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2015 at 23:44, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 10/26/2015 09:20 PM, Ard Biesheuvel wrote:
>>
>> Thanks for the report. The following patch should fix it
>
>
> Ard,
>
> Thanks, it does fix the build problem...
>
> Now to get the darn thing to boot (not related to this AFAIK).
>

Catalin,

Would you like me to resend this as a separate patch?

-- 
Ard.
