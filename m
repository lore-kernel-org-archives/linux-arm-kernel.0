From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 26 Oct 2015 10:12:57 +0000
Subject: [GIT PULL] arm64: Juno: Add support for PCIe or R1 board
In-Reply-To: <4136958.Qhq5GfeeVa@wuerfel>
References: <20151021113629.GF3394@e106497-lin.cambridge.arm.com>
 <4136958.Qhq5GfeeVa@wuerfel>
Message-ID: <20151026101256.GF963@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 10:42:53PM +0200, Arnd Bergmann wrote:
> On Wednesday 21 October 2015 12:36:29 Liviu Dudau wrote:
> > The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:
> > 
> >   Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)
> > 
> > are available in the git repository at:
> > 
> > 
> 
> Not pulled.
> 
> All our branches are based on -rc4 or earlier, and we'd like to avoid
> backmerges from mainline if at all possible.
> 
> Can you rebase this to -rc4 and send again?
> 
> 	Arnd

Sure, I've rebased the branch on top of -rc4 now, so here is the new request.

Many thanks,
Liviu

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://linux-arm.org/linux-ld for-upstream/juno-pcie

for you to fetch changes up to 324e84cb9265120b49c4835ae850e4b83228aa73:

  arm64: defconfig: Enable PCI generic host bridge by default (2015-10-26 10:02:52 +0000)

----------------------------------------------------------------
Liviu Dudau (3):
      Documentation: of: Document the bindings used by Juno R1 PCIe host bridge
      arm64: Juno: Add support for the PCIe host bridge on Juno R1
      arm64: defconfig: Enable PCI generic host bridge by default

 .../devicetree/bindings/pci/arm,juno-r1-pcie.txt     | 10 ++++++++++
 .../devicetree/bindings/pci/plda,xpressrich3-axi.txt | 12 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt          |  1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                  | 20 ++++++++++++++++++++
 arch/arm64/configs/defconfig                         |  1 +
 5 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt



-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
