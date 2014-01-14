From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Tue, 14 Jan 2014 16:07:55 +0000
Subject: [PATCH V2 0/6] Enable X-Gene platform reboot driver.
In-Reply-To: <1389135041-16062-1-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
Message-ID: <20140114160755.GC4307@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:50:35PM -0800, Feng Kan wrote:
> Enable X-Gene platform driver for the X-Gene platform. Remove the
> use of the mask attribute from the reboot dts node. Add support
> for using the ACPI and DTS resource for the reboot driver.

Why can't you just use the standard ACPI reboot register values in the 
FADT?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
