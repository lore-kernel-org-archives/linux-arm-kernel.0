From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jul 2018 08:37:28 -0700
Subject: [GIT PULL v2] ARM: mvebu: arm for v4.19 (#1)
In-Reply-To: <87zhyo8szz.fsf@bootlin.com>
References: <87zhyo8szz.fsf@bootlin.com>
Message-ID: <CAOesGMhgEbPa=FXzx03qTHGdwM-b4DTc0zQJaibnOsDyaQnjgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 8:26 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi,
>
> Here is the first pull request for arm for mvebu for v4.19. It
> supersedes the previous one done one week ago.
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
> for you to fetch changes up to 77bc8c28ddac90287bc42c129002eb703288d550:
>
>   ARM: mvebu: convert secondary CPU clock sync to hotplug state (2018-06-27 08:40:29 +0200)
>
> ----------------------------------------------------------------
> mvebu arm for 4.19 (part 1)
>
>  - remove potential call from invalid context in boot_secondary
>  - allow using CONFIG_FORTIFY_SOURCE in pmsu.c

Merged, thanks!


-Olof
