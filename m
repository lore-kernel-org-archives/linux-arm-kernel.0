From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Nov 2014 15:12:45 +0100
Subject: [Linaro-acpi] [RFC PATCH 3/4] arm64, acpi,
 pci: Add arch specific functions for mmconfig driver.
In-Reply-To: <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org>
 <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <16660879.6KxQndPqBW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014 14:27:55 Tomasz Nowicki wrote:
> These calls allow to map/unmap PCI config space ranges (which are specified in
> MMCFG ACPI table).
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 

Nothing in this patch looks arm64 specific, and most of it looks like a
copy of the x86 code.

	Arnd
