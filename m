From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:42:08 -0700
Subject: [GIT PULL] ARM: mvebu: arm for v4.19 (#1)
In-Reply-To: <87y3egbe7a.fsf@bootlin.com>
References: <87y3egbe7a.fsf@bootlin.com>
Message-ID: <20180714214208.lns2fszqzm6m3q4g@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 06:39:53PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for arm for mvebu for v4.19.
> 
> Gregory
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-arm-4.19-1
> 
> for you to fetch changes up to 432c0254106a373bcc23b1bd3e0b7eb56929c0d9:
> 
>   ARM: mvebu_v7_defconfig: enable SFP support (2018-06-28 16:53:08 +0200)
> 
> ----------------------------------------------------------------
> mvebu arm for 4.19 (part 1)
> 
> defconfig update:
>  - add NAND controller on multi_v7
>  - add SFP support on mvebu_v7
> code improvement:
>  - remove potential call from invalid context in boot_secondary
>  - allow using CONFIG_FORTIFY_SOURCE in pmsu.c

Please separate out soc and defconfig changes to separate branches/pull
requests. If you look at our tree, you'll see that we queue them in
separate branches.

Also, note that we renoramlized the configs in 4.18-rc3, so you want to base
the DT contents on top of that when you send the new pull requests.


Thanks,

-Olof
