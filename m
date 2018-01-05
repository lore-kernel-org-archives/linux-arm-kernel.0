From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 5 Jan 2018 20:22:48 +0530
Subject: [GIT PULL v2 2/2] TI DaVinci DT updates for v4.16
In-Reply-To: <20180105145248.1994-1-nsekhar@ti.com>
References: <20180105145248.1994-1-nsekhar@ti.com>
Message-ID: <20180105145248.1994-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/dt

for you to fetch changes up to 7669b122085018c1f64720d11c24ae6d2549193d:

  ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address (2018-01-05 19:21:21 +0530)

----------------------------------------------------------------
A DT warning fix for W=1 warning message.

----------------------------------------------------------------
Mathieu Malaterre (1):
      ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address

 arch/arm/boot/dts/da850-lcdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
