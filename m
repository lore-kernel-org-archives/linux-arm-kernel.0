From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 8 Dec 2015 13:36:02 +0200
Subject: [PATCH 2/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1449533774-22672-3-git-send-email-lho@apm.com>
References: <1449533774-22672-1-git-send-email-lho@apm.com>
 <1449533774-22672-3-git-send-email-lho@apm.com>
Message-ID: <20151208113602.GL1766@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 05:16:14PM -0700, Loc Ho wrote:
> Enable APM X-Gene ACPI I2C device support by adding the
> corresponding ACPI ID. The platform ACPI APD corresponding
> change is required to provide the proper clock frequency input.
> 
> Signed-off-by: Loc Ho <lho@apm.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
