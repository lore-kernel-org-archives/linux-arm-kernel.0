From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 08 Jul 2011 14:41:08 +0400
Subject: [GIT PULL] DaVinci features for v3.1
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D9B56E8@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024D9B56E8@dbde02.ent.ti.com>
Message-ID: <4E16DEC4.4070401@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08-07-2011 13:13, Nori, Sekhar wrote:

> Please pull the following DaVinci features for v3.1.

> This pull request depends on the patch "davinci: dm6467/T EVM: fix setting
> up of reference clock rate" in clean-up pull request for successful build.

> Pulling this after the earlier clean-up pull request generates this merge
> conflict:

> <<<<<<<  HEAD:arch/arm/mach-davinci/include/mach/psc.h
> #define MDSTAT_STATE_MASK	0x1f
> =======
> #define MDSTAT_STATE_MASK 0x1f
> #define MDCTL_FORCE		BIT(31)
>>>>>>>> 8bb2c4813c534d26eba3beb7888fbd3cbc931f62:arch/arm/mach-davinci/include/mach/psc.h

> The resolution is:

> #define MDSTAT_STATE_MASK	0x1f
> #define MDCTL_FORCE		BIT(31)

    BTW, I think I'll send a patch fixing MDSTAT_STATE_MASK to 0x3f today.

WBR, Sergei
