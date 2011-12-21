From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Dec 2011 11:16:37 -0800
Subject: [GIT PULL 5/5] Tegra driver updates for 3.3
In-Reply-To: <CAOesGMgFCiMqGMA4mVFxKT7tQ_OK+XbAgwXrnvWKp=N2LAouKQ@mail.gmail.com>
References: <CAOesGMgFCiMqGMA4mVFxKT7tQ_OK+XbAgwXrnvWKp=N2LAouKQ@mail.gmail.com>
Message-ID: <CAOesGMj7aOwtVbvW=ror_BZLHZciFge+_=Gdou5i1Ltk+hBBfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 11:15 AM, Olof Johansson <olof@lixom.net> wrote:
> Arnd,
>
> Please pull the below driver updates for tegra for 3.3. They are two
> device-tree-enablement related patches for i2c, I haven't seen acks
> from Ben on them but they are trivial and tegra-specific patches so I
> picked them up anyway.

Pasted in the wrong git request-pull output. Here is the correct one:


The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/drivers

Stephen Warren (2):
      i2c: tegra: Add __devinit/exit to probe/remove
      i2c: tegra: Support DVC controller in device tree

 drivers/i2c/busses/i2c-tegra.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)
