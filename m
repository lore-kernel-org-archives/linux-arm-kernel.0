From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 22:48:52 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable required QCOM SPMI/PMIC
 drivers
In-Reply-To: <1448518557-14250-1-git-send-email-agross@codeaurora.org>
References: <1448518557-14250-1-git-send-email-agross@codeaurora.org>
Message-ID: <6433130.zBIiuq5ZJ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 November 2015 00:15:57 Andy Gross wrote:
> This patch enables the QCOM SPMI and PMIC related drivers that are now
> required to boot some supported devices.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> 

Applied to next/defconfig. I assume you didn't mean this to go into 4.4.

	Arnd
