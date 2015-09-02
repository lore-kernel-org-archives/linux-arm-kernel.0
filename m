From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 02 Sep 2015 11:11:05 +0100
Subject: [PATCH 00/14] arm64: 16K translation granule support
In-Reply-To: <CAKv+Gu-fbC9hFj4cvGWd4sEvxPaR-nfgWS7C+e+jdRTGKOtp4A@mail.gmail.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu-fbC9hFj4cvGWd4sEvxPaR-nfgWS7C+e+jdRTGKOtp4A@mail.gmail.com>
Message-ID: <55E6CB39.5000305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/15 10:55, Ard Biesheuvel wrote:
> On 13 August 2015 at 13:33, Suzuki K. Poulose <suzuki.poulose@arm.com> wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>

>> Patches 1-7 cleans up the kernel page size handling code.
>> Patches 8-11 Fixes some issues with the KVM bits, mainly the fake PGD
>>               handling code.
>> Patch 12    Adds a check to ensure the CPU supports the selected granule size.
>> Patch 13-14 Adds the 16k page size support bits.
>>
>> This series applies on top of for-next/core branch of the aarch64 tree and is
>> also available here:
>>
>>          git://linux-arm.org/linux-skp.git  16k/v1
>>
>
>
> Hi Suzuki,
>
> I have given this a spin on the FVP Base model to check UEFI booting,
> and everything seems to work fine. (I tested 2-level and 3-level)
> I didn't test the KVM changes, so for all patches except those:
>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks for the review and testing !!

Suzuki
