From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 20 Jun 2016 18:07:22 +0300
Subject: [PATCH v4 1/2] i2c: qup: add ACPI support
In-Reply-To: <5768051E.3020008@codeaurora.org>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <20160618141034.GB1430@tetsubishi>
 <20160620082420.GX1739@lahna.fi.intel.com>
 <5768051E.3020008@codeaurora.org>
Message-ID: <20160620150722.GP1739@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 10:00:46AM -0500, Timur Tabi wrote:
> Mika Westerberg wrote:
> > Use has_acpi_companion() if you need to.
> 
> Is has_acpi_companion() the preferred alternative to ACPI_HANDLE()?  We
> frequently need to write code that does something different on ACPI vs DT,
> and there doesn't appear to be much consistency on how that's handled.

Yes, that's the preferred one.
