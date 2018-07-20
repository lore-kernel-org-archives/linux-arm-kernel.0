From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:06:04 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.19
Message-ID: <cover.1532081674.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT bindings updates for v4.19.


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.19

for you to fetch changes up to a7eaad7f7517ba7cdabfeb28fa05bae4e70b4b5a:

  dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method. (2018-06-28 14:07:21 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.19

Bindings relating to initial support for RZ/N1D (R9A06G032) SoC and its
RZN1D-DB board:

* Add Renesas R9A06G032 SMP enable method

  To be used to enable second CA7 CPU

* Document SoC and Board bindings

----------------------------------------------------------------
Michel Pollet (2):
      dt-bindings: arm: Document the RZN1D-DB board
      dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method.

 Documentation/devicetree/bindings/arm/cpus.txt     | 1 +
 Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)
