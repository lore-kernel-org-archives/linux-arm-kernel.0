From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 1 Feb 2016 11:44:26 -0500
Subject: [PATCH V13 09/10] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56AF87E2.8040201@linaro.org>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-10-git-send-email-okaya@codeaurora.org>
 <56AF82FA.7000303@linaro.org> <56AF84F4.2080809@codeaurora.org>
 <56AF87E2.8040201@linaro.org>
Message-ID: <56AF8B6A.8040504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2016 11:29 AM, Eric Auger wrote:
>> hanks, we should ask Baptiste to get his email into the Maintainer file list.
> I think it is:
> ./scripts/get_maintainer.pl
> 0001-vfio-platform-add-support-for-ACPI-while-detecting-t.patch
> 
> Baptiste Reynal <b.reynal@virtualopensystems.com> (maintainer:VFIO
> PLATFORM DRIVER,commit_signer:1/5=20%)
> Alex Williamson <alex.williamson@redhat.com> (maintainer:VFIO
> DRIVER,commit_signer:2/3=67%,commit_signer:4/5=80%)
> ../..

Strange, I'll reset my tree. 

>> > 
>>> >>
>>> >> On my side I tested with of amd xgbe and I don't observe any regression.
>>> >>
>>> >> Best Regards
>> > 
>> > Can I add your tested by?
> Well to make things clear I did not test the ACPI part. I just can tell
> this does not bring any regression on the of part. But I am not against
> if you don't find anybody else and you tested the ACPI part ;-)
> 

How about?

of-tested-by: ...

Shanker and I tested ACPI before pushing the patches to the list and we also 
posted the corresponding QEMU patches as well to the qemu-devel maillist.

http://patchwork.ozlabs.org/patch/575878/

I'll ask him to add his acpi-tested-by for the ACPI part.

> Best Regards


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
