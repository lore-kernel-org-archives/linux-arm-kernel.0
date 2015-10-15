From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:21:37 +0200
Subject: [GIT PULL] qcom dt changes for 4.4 *RESEND*
In-Reply-To: <1444860618-8192-1-git-send-email-agross@codeaurora.org>
References: <1444860618-8192-1-git-send-email-agross@codeaurora.org>
Message-ID: <6104133.mh1hYu2Hx7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 17:10:18 Andy Gross wrote:
> Qualcomm ARM Based Device Tree Updates for v4.4
> 
> * Add DT binding document for SMEM
> * Add SMD, RPM, and Regulator nodes on MSM8974
> * Remove extra reg element from iadc device
> * Remove redunandant i2c pinctrl properties on APQ8064
> * Remove unnecessary eeprom label on IFC6410
> * Remove unnecessary eeprom label from QS600
> * Add PM8921 RTC support on APQ8064
> * Add PM8921 pwrkey support on APQ8064
> * Prefix GSBI6 uart pins on APQ8064 correctly
> * Add missing GSBI7 uart pinctrl on APQ8064
> * Add missing GSBI7 uart pinctrl on IFC6410
> * Add missing GSBI7 pinctrl uart property on QS600
> * Add pwrseq support for WLAN on IFC6410
> * Add pwrseq support for WLAN on QS600
> * Add notify led support on IFC6410
> * Add SD card detect support onQS600
> * Add #power-domain-cells property to documentation
> * Add Qualcomm SMBB binding document
> * Add PM8941 charge node
> * Fix typo in disabled property on MSM8974
> 

Pulled into next/dt, thanks!

	Arnd
