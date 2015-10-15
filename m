From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 16 Oct 2015 07:42:54 +0800
Subject: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
In-Reply-To: <561FFB4C.1000500@redhat.com>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <561FFB4C.1000500@redhat.com>
Message-ID: <562039FE.9050004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2015 03:15 AM, Jon Masters wrote:
> Hi Hanjun,
>
> Thanks for your hard work on ARM64 PCI host bridge/root complex so far!
>
> On 05/26/2015 08:49 AM, Hanjun Guo wrote:
>> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
>> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
>> code into ACPI core":
>>
>> https://lkml.org/lkml/2015/5/14/98
>
> The latest version (v7) of the ACPI PCI root common code consolidation
> series was posted by Gerry (Jiang Liu) yesterday:
>
> https://lkml.kernel.org/g/1444804182-6596-1-git-send-email-jiang.liu at linux.intel.com
>
> This got me wondering what the status is of the ARM64 specific
> hostbridge patch series that has a dependency upon the former. Are you
> planning to wait for that series to be accepted or post a newer rebased
> version for additional review, or something else?

Tomasz and Lorenzo are discussing about the PCI config based
OperationRegions, which still have no conclusion yet, Lorenzo
started a discussion on ASWG and hope can get some feedback.

Other than that, Tomasz volunteered to cleanup this patch set, I
think we need to rebase on Jiang's v7 patchset which was accepted
By Rafael, of course I will work with Tomasz to prepare those
patches.

Thanks
Hanjun
