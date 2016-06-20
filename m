From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 20 Jun 2016 10:00:46 -0500
Subject: [PATCH v4 1/2] i2c: qup: add ACPI support
In-Reply-To: <20160620082420.GX1739@lahna.fi.intel.com>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <20160618141034.GB1430@tetsubishi> <20160620082420.GX1739@lahna.fi.intel.com>
Message-ID: <5768051E.3020008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg wrote:
> Use has_acpi_companion() if you need to.

Is has_acpi_companion() the preferred alternative to ACPI_HANDLE()?  We 
frequently need to write code that does something different on ACPI vs 
DT, and there doesn't appear to be much consistency on how that's handled.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
