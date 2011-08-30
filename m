From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Aug 2011 12:46:35 -0600 (MDT)
Subject: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
In-Reply-To: <1314119594-22647-1-git-send-email-hemantp@ti.com>
References: <1314119594-22647-1-git-send-email-hemantp@ti.com>
Message-ID: <alpine.DEB.2.00.1108301246170.26173@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2011, Hemant Pedanekar wrote:

> This patch set is the v2 of TI816X clock and hwmods patches sent earlier.
> 
> The clock data is currently added only for TI816X, while minimal hwmod data
> common for TI816X and TI814X is added.
> 
> This patch set depends on following patches:
> 	TI81XX: Prepare for addition of TI814X support
> 	TI814X: Add cpu type macros and detection support
> 	TI814X: Create board support and enable build for TI8148 EVM
> 
> Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I will
> send update once SoC list usage is available.	

Thanks - am working away on these patches & hope to have them out soon.


- Paul
