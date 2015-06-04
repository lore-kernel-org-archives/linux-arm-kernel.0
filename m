From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 04 Jun 2015 09:54:55 +0800
Subject: [Patch v4 0/8] Consolidate ACPI PCI root common code into ACPI
 core
In-Reply-To: <556F6332.2040501@redhat.com>
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
 <556F6332.2040501@redhat.com>
Message-ID: <556FAFEF.6040802@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/6/4 4:27, Al Stone wrote:
> On 06/02/2015 12:12 AM, Jiang Liu wrote:
>> This patch set consolidates common code to support ACPI PCI root on x86
>> and IA64 platforms into ACPI core, to reproduce duplicated code and
>> simplify maintenance. And a patch set based on this to support ACPI based
>> PCIe host bridge on ARM64 has been posted at:
> 
> Link is missing (or it's a typo of some flavor).
HI Al,
	Sorry, I missed the link. It has been posted at:
https://lkml.org/lkml/2015/5/26/207
Thanks!
Gerry
