From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Jul 2018 17:41:24 +0200
Subject: [GIT PULL 1/5] dt-bindings: tegra: Changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-1-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
Message-ID: <20180712154128.22705-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-dt-bindings

for you to fetch changes up to 29aa59efc6bf91cfa5bfba8375fd730150a19d3f:

  dt-bindings: arm: Add compatible string for NVIDIA Carmel (2018-07-02 15:58:25 +0200)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: tegra: Changes for v4.19-rc1

This contains a single update that adds the Carmel CPU found in Tegra194
SoCs to the arm/cpus.txt device tree bindings.

----------------------------------------------------------------
Mikko Perttunen (1):
      dt-bindings: arm: Add compatible string for NVIDIA Carmel

 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)
