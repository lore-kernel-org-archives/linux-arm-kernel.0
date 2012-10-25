From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Oct 2012 11:04:41 -0700
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <50882B6E.5020103@wwwdotorg.org>
References: <1351099475-29349-1-git-send-email-sboyd@codeaurora.org>
 <50882B6E.5020103@wwwdotorg.org>
Message-ID: <50897F39.9030702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/12 10:54, Stephen Warren wrote:
> Where will this patch be merged?
>
> It probably won't happen for 3.8, but that config fragment will move to
> arch/arm/mach-tegra/Kconfig when Tegra enables single zImage support, I
> believe. So, it'd be good to make sure this patch gets merged somewhere
> that could be used as a baseline for other arm-soc branches if needed,
> to avoid merge conflicts.

I was hoping this could go through the arm-soc tree for the 3.8 merge
window.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
