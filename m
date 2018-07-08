From: olof@lixom.net (Olof Johansson)
Date: Sun, 8 Jul 2018 09:12:32 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config update for v4.19
In-Reply-To: <1530912342-4641-2-git-send-email-santosh.shilimkar@oracle.com>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
 <1530912342-4641-2-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <20180708161232.23erjlj4fqqc2ici@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 02:25:41PM -0700, Santosh Shilimkar wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.19
> 
> for you to fetch changes up to 60e9343b355118e903a155135f0511918d69e3ac:
> 
>   ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP (2018-06-29 15:57:53 -0700)
> 
> ----------------------------------------------------------------
> ARM: Keystone config updates for 4.19
> 
>  - Enable MMC support
>  - Enable Micrel and DP83867 phys
> 
> ----------------------------------------------------------------
> Kishon Vijay Abraham I (1):
>       ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
> 
> Murali Karicheri (1):
>       ARM: keystone: k2g: enable micrel and dp83867 phys

Merged, but if you look at the git log --oneline of arch/arm/configs you'll see
that we try to use "ARM: keystone_defconfig: <...>" as the prefix style.


-Olof
