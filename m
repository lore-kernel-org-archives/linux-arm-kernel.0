From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 31 Mar 2014 15:43:00 -0400
Subject: [PATCH v6 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <CAJ5Y-eb=JFtHWgLpxxm+L8z0w92GjBcJyUo8hWj6ik6GoakrtQ@mail.gmail.com>
References: <1396262773-7723-1-git-send-email-anup.patel@linaro.org>
 <1396262773-7723-3-git-send-email-anup.patel@linaro.org>
 <20140331180722.GD4756@lvm>
 <CAJ5Y-eaGsM4Moz815P7QM=7qh87RyzU-MVyeLOT64CLEaR0HQA@mail.gmail.com>
 <20140331183629.GF4756@lvm>
 <CAJ5Y-eb=JFtHWgLpxxm+L8z0w92GjBcJyUo8hWj6ik6GoakrtQ@mail.gmail.com>
Message-ID: <CAJ5Y-ebjR3zdYrDx2HReXeCG2wSYwVgBXBdezjoQFKFmOcj7YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 March 2014 15:26, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hi Christoffer,
>
> On 31 March 2014 14:36, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>
>>>
>> I think Marc brought up the point previously that we may get to PSCI
>> spec v42.17 and the defines should perhaps encompass the version we are
>> defining things for right now...
>>
>> That being said, assuming new spec versions don't break backwards
>> compatibility in the numbering, the wording proposed by your patch does
>> look simpler.
>>
>> I do like the hardcoded IDs because that's how it's presented in the
>> spec itself.
>
> Cool. I'll just add the following line in kbuild to this patch and resend.

by "this" patch, I  meant my version. Sorry if I caused any confusion. :)

>
>  include/uapi/linux/Kbuild |    1 +
>
> +header-y += psci.h
>
> Meanwhile, if there are any strong preferences to using the uapi
> header in Anup's patch, then I can rebase later.
>
> Thanks,
> Ashwin
