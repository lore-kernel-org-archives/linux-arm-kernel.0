From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 5 Oct 2018 10:28:05 +0200
Subject: [GIT PULL] updates for DT 32bit for v4.20 round 2
Message-ID: <6cd94d4a-63d0-5959-2fe2-c0c084f38ad7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Hi Olof,

Please have a look on the commits below. They are the second round of the
arm 32 bit device tree patches. The pull request is based on the first one
(v4.19-next-dts32) that you already merged.

Thanks a lot,
Matthias

---

The following changes since commit 5646a2f6d584e80bd4555c2ce3e286b35b9eaa61:

  arm: dts: mt7623: add jpeg decoder device node (2018-09-25 17:44:35 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.19-next-dts32-2

for you to fetch changes up to f5e489e6ee7a7c8fb7c3ed3997597a109f0813aa:

  dt-bindings: mediatek: Add bindig for MT7623 IOMMU and SMI (2018-10-05
10:11:33 +0200)

----------------------------------------------------------------
Add binding description for devices from
MT7623. Clock controller, iommu, JPEG Decoder
and SMI conotroller.

----------------------------------------------------------------
Matthias Brugger (4):
      dt-bindings: clock: mediatek: add support for MT7623
      dt-bindings: iommu: mediatek: Add binding for MT7623
      dt-bindings: mediatek: Add JPEG Decoder binding for MT7623
      dt-bindings: mediatek: Add bindig for MT7623 IOMMU and SMI

 .../devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt          | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt  | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt     | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt  | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt   | 1 +
 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt            | 4 +++-
 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt     | 1 +
 .../devicetree/bindings/memory-controllers/mediatek,smi-common.txt    | 1 +
 .../devicetree/bindings/memory-controllers/mediatek,smi-larb.txt      | 3 ++-
 15 files changed, 18 insertions(+), 2 deletions(-)
