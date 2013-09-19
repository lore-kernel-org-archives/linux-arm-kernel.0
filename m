From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Sep 2013 10:48:58 -0700
Subject: [GIT PULL] DaVinci fixes for v3.12-rc
In-Reply-To: <523AD060.8000504@ti.com>
References: <523AD060.8000504@ti.com>
Message-ID: <CAOesGMg_L-0kqY2oexV=WY4mEWpCQdAej_h8QGxrtCgC=xSijg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Thu, Sep 19, 2013 at 3:22 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>
>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.12-rc2
>
> for you to fetch changes up to caf9269f883bf0d5b83384efb96e2aa572d1d013:
>
>   ARM: edma: dt: create unused channel list (2013-09-19 15:13:32 +0530)
>
> ----------------------------------------------------------------
> DaVinci fixes for v3.12-rc2
> ---------------------------
>
> This pull request includes:
>
> 1) A patch to fix build breakage with DEBUG_LL
> 2) A patch to quell a build-time warning.
> 3) A patch to complete the DT support for EDMA. Without
>    this patch, the DT support for EDMA cannot be used.
>    There are no in-tree DT users of EDMA currently but
>    nevertheless the patch fixes a previously incomplete
>    implementation.

Finishing incomplete work is not a fix, especially if the users aren't
in-tree. The other patches are just fine to include though.

Want to rebuild the branch (and stage the EDMA work for 3.13), or
should I pick the patches into branches at our end? Your choice.


-Olof
