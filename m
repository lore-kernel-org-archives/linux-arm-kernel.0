From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 22 Dec 2015 15:17:36 +0000
Subject: [GIT PULL] Add idle states to Juno device-tree
Message-ID: <1450797456.3037.2.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people

Please consider these device-tree updates for inclusion into Linux.
This is a pull request for the single patch discussed on the lists [1]
a couple of weeks ago, and I'm sending it as a pull request in the hope
that it will be more noticeable.

Thanks

Tixy

[1] http://www.spinics.net/lists/arm-kernel/msg467219.html

------------------------------------------------------------------

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.linaro.org/people/tixy/kernel.git juno-idle-dts

for you to fetch changes up to 8ea5bf9418d621a27398a0d98987382343f0e94c:

  arm64: dts: juno: Add idle-states to device tree (2015-12-22 14:51:59 +0000)

----------------------------------------------------------------
Jon Medhurst (1):
      arm64: dts: juno: Add idle-states to device tree

 arch/arm64/boot/dts/arm/juno-r1.dts | 28 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts    | 28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
