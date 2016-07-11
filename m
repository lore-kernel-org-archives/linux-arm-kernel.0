From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Jul 2016 17:25:12 +0200
Subject: [GIT PULL 4/4] arm64: tegra: Default configuration updates for
 v4.8-rc1
In-Reply-To: <20160711152512.11731-1-thierry.reding@gmail.com>
References: <20160711152512.11731-1-thierry.reding@gmail.com>
Message-ID: <20160711152512.11731-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-arm64-defconfig

for you to fetch changes up to 10a7b37b5b969d9998912e50946f7a03111037eb:

  arm64: Update default configuration (2016-07-11 16:50:20 +0200)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Default configuration updates for v4.8-rc1

Enable a bunch of configuration options to enable PMIC, regulators, DSI,
HDMI, XUSB and the GPU on Jetson TX1 as well as a few new features that
are now functional on the Google Pixel C.

----------------------------------------------------------------
Thierry Reding (1):
      arm64: Update default configuration

 arch/arm64/configs/defconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
