From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:28:29 -0800
Subject: [GIT PULL] STi defconfig updates for v4.10 round 2
In-Reply-To: <919f7b55-a2cd-fc20-a1cd-4d3f309fd60d@st.com>
References: <919f7b55-a2cd-fc20-a1cd-4d3f309fd60d@st.com>
Message-ID: <20161118072829.GE1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:00:32AM +0100, Patrice Chotard wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider the second round of multi_v7_defconfig updates for v4.10 :
> 
> 
> The following changes since commit 620c52f4db4d47e1f33c64e641392fe575d5397f:
> 
>   ARM: multi_v7_defconfig: Remove stih41x phy Kconfig symbol. (2016-10-20 17:05:08 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git sti-defconfig-for-4.10-round2
> 
> for you to fetch changes up to 57dae748959d0abae2b382ccee68621a82f827c8:
> 
>   ARM: multi_v7_defconfig: Remove ST_THERMAL_SYSCFG Kconfig symbol (2016-10-21 17:05:54 +0200)
> 
> ----------------------------------------------------------------
> 
> Remove STiH415/416 specific IPs
> 
> As STiH415/416 have been removed from kernel, remove IPs only
> found on these socs, remove ST_THERMAL_SYSCFG.

Merged, thanks.


-Olof
