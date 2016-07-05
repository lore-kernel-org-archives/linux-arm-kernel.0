From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Jul 2016 20:52:12 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config updates for 4.8
In-Reply-To: <1466527923-8689-2-git-send-email-ssantosh@kernel.org>
References: <1466527923-8689-1-git-send-email-ssantosh@kernel.org>
 <1466527923-8689-2-git-send-email-ssantosh@kernel.org>
Message-ID: <20160705035212.GD1669@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 09:52:02AM -0700, Santosh Shilimkar wrote:
> The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:
> 
>   Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.8
> 
> for you to fetch changes up to 229a4bc846e85461252ab7aec3ab2cae4bf22a9c:
> 
>   ARM: keystone: remove redundant depends on ARM_PATCH_PHYS_VIRT (2016-06-14 17:56:51 -0700)

Merged into next/defconfig, however note:
> 
> ----------------------------------------------------------------
> ARM: Keystone config updates for 4.8
> 
> 	- Enable PINCTRL support
> 	- Remove redundant ARM_PATCH_PHYS_VIRT
> 
> ----------------------------------------------------------------
> Franklin S Cooper Jr (1):
>       ARM: keystone: Enable PINCTRL_SINGLE Config
> 
> Lokesh Vutla (1):
>       ARM: keystone: Enable PINCTRL config
> 
> Masahiro Yamada (1):
>       ARM: keystone: remove redundant depends on ARM_PATCH_PHYS_VIRT

We normally don't mix in mach* contents here. It's a tiny patch though so it's
not a showstopper, but if you sort them in a soc branch if you have more in
the future that'd be preferred.


-Olof
