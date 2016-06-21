From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 21 Jun 2016 10:34:45 -0400
Subject: [PATCH 4/4] MAINTAINERS: Update BCM281XX/BCM11XXX/BCM216XX entry
In-Reply-To: <CAMsMSK-7WOuzVNASmLdAsm8PzRARJCZB5zVReZmfZPCYLtg=HQ@mail.gmail.com>
References: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
 <1466456857-11969-5-git-send-email-jon.mason@broadcom.com>
 <CAMsMSK-7WOuzVNASmLdAsm8PzRARJCZB5zVReZmfZPCYLtg=HQ@mail.gmail.com>
Message-ID: <CAC3K-4qpqWBVAj=kXC3rt7WoDDOgSFKE92DmTy6cJw7eXBwVEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 5:35 PM, Chris Brand <chris.brand@broadcom.com> wrote:
> On Mon, Jun 20, 2016 at 2:07 PM, Jon Mason <jon.mason@broadcom.com> wrote:
>> There are many clock, pinctl, and misc others that should be covered
>> under the BCM281XX/BCM11XXX/BCM216XX ARM listing.  Change the entry to
>> use regex's that should cover all the files.
>>
>> Also, remove the bcm_defconfig entry (as the file is being removed), and
>> arch/arm64/boot/dts/broadcom reference (as that is not accurate for this
>> group of maintainers and all the device trees under it should now be
>> covered by other maintainer entries).
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>>  MAINTAINERS | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 28a35f4..01382ce 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2481,14 +2481,11 @@ M:      Scott Branden <sbranden@broadcom.com>
>>  L:     bcm-kernel-feedback-list at broadcom.com
>>  T:     git git://github.com/broadcom/mach-bcm
>>  S:     Maintained
>> +N:     bcm281*
>> +N:     bcm113*
>> +N:     bcm216*
>> +N:     kona
>
> Hmmm. We should probably add bcm23550 here, too.

Sure, I'll be happy to ammend this patch to add "N:    bcm23550",
which appears to cover all of the newly added files.  Also, does it
make sense to add you to the list of maintainers above?

Thanks,
Jon

>>  F:     arch/arm/mach-bcm/
>> -F:     arch/arm/boot/dts/bcm113*
>> -F:     arch/arm/boot/dts/bcm216*
>> -F:     arch/arm/boot/dts/bcm281*
>> -F:     arch/arm64/boot/dts/broadcom/
>> -F:     arch/arm/configs/bcm_defconfig
>> -F:     drivers/mmc/host/sdhci-bcm-kona.c
>> -F:     drivers/clocksource/bcm_kona_timer.c
>>
>>  BROADCOM BCM2835 ARM ARCHITECTURE
>>  M:     Stephen Warren <swarren@wwwdotorg.org>
>
> Chris
