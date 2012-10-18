From: olof@lixom.net (Olof Johansson)
Date: Wed, 17 Oct 2012 17:16:15 -0700
Subject: [GIT PULL 3/3] ARM: Kirkwood: fix for v3.7
In-Reply-To: <E1TOZFq-0003tI-4I@merlin.infradead.org>
References: <E1TOZFq-0003tI-4I@merlin.infradead.org>
Message-ID: <CAOesGMggrOK49vvAsVud+eO4gsTt-+x8UcLfR_zJc9RSrtARdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 17, 2012 at 12:25 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
>
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/jcooper/linux.git tags/kirkwood_cache_build_fix_for_v3.7
>
> for you to fetch changes up to f7d87d2726f823dc4a0d4900ac06446e4e485fdb:
>
>   Build failure CONFIG_ARCH_KIRKWOOD_DT relies on CACHE_FEROCEON_L2 (2012-10-17 17:56:37 +0000)
>
> ----------------------------------------------------------------
> Depends:
>  - Based on v3.7-rc1

These dependencies don't really make sense to have in the tag -- the
tag shows up by default in the merge commit and once the branch is
merged, the dependencies aren't really useful. So while it might be
good to have in the pull request (at least for non-trivial
dependencies/bases), having it in the tag means I just edit it out
when I touch up the merge message.

> Jason Gunthorpe (1):
>       Build failure CONFIG_ARCH_KIRKWOOD_DT relies on CACHE_FEROCEON_L2

Please fix the patch subject format here.


-Olof
