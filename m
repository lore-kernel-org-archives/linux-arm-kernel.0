From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 May 2016 12:29:57 -0700
Subject: [PATCH 1/3] ARM: dts: NSP: Add MSI support on PCI
In-Reply-To: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
References: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
Message-ID: <573B7135.2050604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 04:29 PM, Jon Mason wrote:
> Add MSI support to the PCI driver of the Northstar Plus SoC.  This uses
> the existing pcie-iproc driver.  So, all that is needed is device tree
> entries in the DTS.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

All applied, thanks! Just for next time, can you include a cover letter
for multi series patches?
-- 
Florian
