From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 22:44:19 +0200
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <95C66A63-9671-4AD5-9804-6647A305DB99@codeaurora.org>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <4495090.ktpdXEyibD@wuerfel>
 <95C66A63-9671-4AD5-9804-6647A305DB99@codeaurora.org>
Message-ID: <5976198.MmsV3dNjlq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 15:43:02 Kumar Gala wrote:
> Its imx6 and exynos, havent looked to see if dw-pcie is handling
> the parsing or not for them.

Ok, so they are both dw-pcie variants.

	Arnd 
