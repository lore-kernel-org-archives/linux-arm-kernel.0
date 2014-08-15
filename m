From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 15 Aug 2014 15:55:10 +0200
Subject: [PATCH v2] efi/arm64: store Runtime Services revision
In-Reply-To: <20140815134324.GY15082@console-pimps.org>
References: <1408108964-28650-1-git-send-email-semen.protsenko@linaro.org>
 <CAKv+Gu9ABf9VzMiT-nA1tt8tbjimCZGatiT1ucwcFTnt7qdmfQ@mail.gmail.com>
 <20140815134324.GY15082@console-pimps.org>
Message-ID: <CAKv+Gu8Ec+=Trt=cUe3HKd17tSLd6+TY_ki9FRSdD8D+NLvwNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2014 15:43, Matt Fleming <matt@console-pimps.org> wrote:
> On Fri, 15 Aug, at 03:38:48PM, Ard Biesheuvel wrote:
>> On 15 August 2014 15:22, Semen Protsenko <semen.protsenko@linaro.org> wrote:
>> > "efi" global data structure contains "runtime_version" field which must
>> > be assigned in order to use it later in Runtime Services virtual calls
>> > (virt_efi_* functions).
>> >
>> > Before this patch "runtime_version" was unassigned (0), so each
>> > Runtime Service virtual call that checks revision would fail.
>> >
>> > Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
>>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> @Matt, could you take this?
>
> Certainly. Looks like this should go into the 'urgent' queue and be
> tagged for stable?
>

Yes, please (for 3.16)

-- 
Ard.
