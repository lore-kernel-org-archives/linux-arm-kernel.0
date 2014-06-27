From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 11:09:27 +0200
Subject: [Linaro-acpi] [PATCH v4 12/13] ARM64 / ACPI: if we chose to boot
 from acpi then disable FDT
In-Reply-To: <1403840976-7456-13-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-13-git-send-email-hanjun.guo@linaro.org>
Message-ID: <5766378.doqChWUeyl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 June 2014 11:49:35 Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> If the early boot methods of acpi are happy that we have valid ACPI
> tables and acpi=off has not been passed. Then do not unflat devicetree
> effectively disabling further hardware probing from DT.
> 

I guess this answers the question I had on patch 4 ;-)

	Arnd
