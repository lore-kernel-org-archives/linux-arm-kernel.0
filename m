From: fainelli@broadcom.com (Florian Fainelli)
Date: Fri, 7 Aug 2015 10:20:08 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.3 (part 2)
In-Reply-To: <1438796683-18581-3-git-send-email-f.fainelli@gmail.com>
References: <1438796683-18581-1-git-send-email-f.fainelli@gmail.com>
 <1438796683-18581-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <55C4E8C8.7030503@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

Can you drop this pull request, or if you already merged it, there will
be a second one for a single patch coming in shortly. Thank you!

On 05/08/15 10:44, Florian Fainelli wrote:
> The following changes since commit 39aa437e18cac7acae55481ed73feea0de497399:
> 
>   Merge branch 'queue/irq/arm' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into next/cleanup (2015-08-05 17:24:11 +0200)
> 
> are available in the git repository at:
> 
>   http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/soc-part2
> 
> for you to fetch changes up to 661e59d30168331e5e1c7386d23ea8fd14965270:
> 
>   ARM: BCM: Enable ARM erratum 798181 for BRCMSTB (2015-08-05 10:30:59 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains the following changes:
> 
> - Gregory updates the BRCMSTB Kconfig to select the ARM erratum 798181 which
>   affects the chips covered by this platform
> 
> ----------------------------------------------------------------
> Gregory Fong (1):
>       ARM: BCM: Enable ARM erratum 798181 for BRCMSTB
> 
>  arch/arm/mach-bcm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 


-- 
Florian
