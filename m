From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Jul 2016 16:50:05 -0700
Subject: [PATCH] arm64: Add Broadcom Set Top Box Kconfig entry point
In-Reply-To: <1467229774-20738-1-git-send-email-mmayer@broadcom.com>
References: <1467229774-20738-1-git-send-email-mmayer@broadcom.com>
Message-ID: <578430AD.5020002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 12:49 PM, Markus Mayer wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> Add an ARCH_BRCMSTB Kconfig symbol which allows us not to update the
> dependencies for all STB-related drivers. Select BRCMSTB_L2_IRQ and
> GENERIC_IRQ_CHIP which are required for proper functioning.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Applied to soc-arm64/next thanks Markus!
-- 
Florian
