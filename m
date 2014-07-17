From: tony.luck@intel.com (Luck, Tony)
Date: Thu, 17 Jul 2014 16:58:18 +0000
Subject: [PATCH v2 1/3] ACPI: ARM64 does not have a BIOS add config for
 BIOS table scan.
In-Reply-To: <53C7406E.40902@linaro.org>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
 <1404898746-6685-2-git-send-email-hanjun.guo@linaro.org>
 <53C70CCC.2080109@zytor.com>
 <3908561D78D1C84285E8C5FCA982C28F3285FB3C@ORSMSX114.amr.corp.intel.com>
 <53C70F78.40206@zytor.com> <53C7406E.40902@linaro.org>
Message-ID: <3908561D78D1C84285E8C5FCA982C28F32866139@ORSMSX113.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Tony, if it is ok with you, I will modify the patch and will not select
> ACPI_LEGACY_TABLES_LOOKUP on IA64, I'm waiting for your final confirmation.

Confirmed.  Thanks Peter for catching this.

-Tony
