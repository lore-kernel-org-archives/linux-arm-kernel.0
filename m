From: jcm@redhat.com (Jon Masters)
Date: Thu, 15 Oct 2015 15:15:24 -0400
Subject: [PATCH 00/11] ARM64 PCI hostbridge init based on ACPI
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <561FFB4C.1000500@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

Thanks for your hard work on ARM64 PCI host bridge/root complex so far!

On 05/26/2015 08:49 AM, Hanjun Guo wrote:
> This patch set is introducing ARM64 PCI hostbridge init based on ACPI,
> which based on Jiang Liu's patch set "Consolidate ACPI PCI root common
> code into ACPI core":
> 
> https://lkml.org/lkml/2015/5/14/98

The latest version (v7) of the ACPI PCI root common code consolidation
series was posted by Gerry (Jiang Liu) yesterday:

https://lkml.kernel.org/g/1444804182-6596-1-git-send-email-jiang.liu at linux.intel.com

This got me wondering what the status is of the ARM64 specific
hostbridge patch series that has a dependency upon the former. Are you
planning to wait for that series to be accepted or post a newer rebased
version for additional review, or something else?

Thanks very much in advance! :)

Jon.
