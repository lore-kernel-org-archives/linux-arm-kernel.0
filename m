From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 28 Apr 2014 13:19:14 -0400
Subject: [PATCH v10 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <CAAhSdy0-U_6GH25n5b6=Od2LVawEyrc8NGORCzGJwdxvVv5yVg@mail.gmail.com>
References: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
 <1398085206-30555-3-git-send-email-anup.patel@linaro.org>
 <20140428141656.GF2868@lvm>
 <CAAhSdy0-U_6GH25n5b6=Od2LVawEyrc8NGORCzGJwdxvVv5yVg@mail.gmail.com>
Message-ID: <CAJ5Y-eaB_PfB4vs_1722-POd_EBdyedakjza7CHdpXxkrBBSQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2014 13:13, Anup Patel <anup@brainfault.org> wrote:

>>> +#define PSCI_0_2_POWER_STATE_ID_MASK         0xffff
>>> +#define PSCI_0_2_POWER_STATE_ID_SHIFT                0
>>> +#define PSCI_0_2_POWER_STATE_TYPE_MASK               0x1
>>
>> Shouldn't this be (0x1 << PSCI_0_2_POWER_STATE_TYPE_SHIFT)?
>>
>> That seems to be the definition of a mask in the PSCI_VERSION_MAJOR_MASK
>> below, at least be consistent in this file.
>
> This was blindly adopted from Ashwin's patchset. I kept it this way so
> that it works for him. May be I should change this for consistency.
>
> I hope this will be fine for Ashwin ??
>

I dont have a problem changing it for consistency reasons.

The original code has it that way:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/psci.c?id=v3.15-rc3

Thanks,
Ashwin
