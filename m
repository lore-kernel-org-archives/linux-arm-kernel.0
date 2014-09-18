From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 19 Sep 2014 01:54:57 +0800
Subject: [GIT PULL v2][for v3.18] pull request from pxa git
Message-ID: <CAD6h2NQN9JSOVmzYuTM8201011nmyG=hxOjwibr4kOLt7b_-iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd, Kevin,

Please help to merge the pull request from pxa git repository.

Best Regards
Haojian

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
tags/pxa-fix-abi

for you to fetch changes up to 7a08cf77dbb976cec39c300201cebfee94552f54:

  ARM: pxa: dts: fix ohci controller compatible string (2014-09-19
01:39:03 +0800)

----------------------------------------------------------------
Since DT aren't fully enabled in pxa2xx, it's fine to merge them in v3.18

----------------------------------------------------------------
Daniel Mack (2):
      ARM: pxa: dts: fix mmc controller compatible string
      ARM: pxa: dts: fix ohci controller compatible string

 arch/arm/boot/dts/pxa2xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
