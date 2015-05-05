From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 05 May 2015 11:10:27 +0800
Subject: [RFC v2 0/7] Consolidate ACPI PCI root common code into ACPI core
In-Reply-To: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com>
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <554834A3.9060204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerry,

On 2015?05?05? 10:46, Jiang Liu wrote:
> This patch set consolidates common code to support ACPI PCI root on x86
> and IA64 platforms into ACPI core, to reproduce duplicated code and
> simplify maintenance. The common code should also used to support PCI
> host bridge on ARM64 too, but I'm lacking of knowledge about PCIe host
> bridge implementation details on ARM64, so please help to review whether
> this is suitable for ARM64 too.

I like the idea and direction of this patch set a lot. :)

I will rebase our ARM64 ACPI PCI host bridge patch on top of your
patchset this week, then I will come up with more detail review
comments and test results, for now, I'm pretty busy with ACPI GIC
patches to support your stacked irqdomains :)

Thanks
Hanjun
