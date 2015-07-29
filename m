From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jul 2015 16:34:21 +0200
Subject: [PATCH] dmaengine: xgene-dma: Add ACPI support for X-Gene DMA
 engine driver
In-Reply-To: <1437484479-2822-1-git-send-email-rsahu@apm.com>
References: <1437484479-2822-1-git-send-email-rsahu@apm.com>
Message-ID: <2384915.JHlOHWBXHy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 July 2015 18:44:39 Rameshwar Prasad Sahu wrote:
> This patch adds ACPI support for the APM X-Gene DMA engine driver.
> 
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> 

How does a slave driver refer to a channel in case of ACPI?

	Arnd
