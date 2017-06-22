From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Jun 2017 11:22:21 -0500
Subject: [PATCH v2] of: update ePAPR references to point to Devicetree
 Specification
In-Reply-To: <1498148139-12770-1-git-send-email-frowand.list@gmail.com>
References: <1498148139-12770-1-git-send-email-frowand.list@gmail.com>
Message-ID: <20170622162221.qxglzqdxpzt6hoho@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 09:15:39AM -0700, frowand.list at gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The Devicetree Specification has superseded the ePAPR as the
> base specification for bindings.  Update files in Documentation
> to reference the new document.
> 
> First reference to ePAPR in Documentation/devicetree/bindings/arm/cci.txt
> is generic, remove it.
> 
> Some files are not updated because there is no hypervisor chapter
> in the Devicetree Specification:
>    Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
>    Documenation/virtual/kvm/api.txt
>    Documenation/virtual/kvm/ppc-pv.txt
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes from v1:
>    - remove boilerplat ePAPR reference from cci.txt
> 
>  Documentation/devicetree/bindings/arm/cci.txt             | 15 ++++-----------
>  Documentation/devicetree/bindings/arm/cpus.txt            | 13 +++++++------
>  Documentation/devicetree/bindings/arm/idle-states.txt     |  4 ++--
>  Documentation/devicetree/bindings/arm/l2c2x0.txt          |  4 ++--
>  Documentation/devicetree/bindings/arm/topology.txt        |  4 ++--
>  Documentation/devicetree/bindings/bus/simple-pm-bus.txt   |  2 +-
>  Documentation/devicetree/bindings/chosen.txt              |  3 ++-
>  Documentation/devicetree/bindings/common-properties.txt   |  2 +-
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt     |  4 ++--
>  Documentation/devicetree/bindings/crypto/fsl-sec6.txt     |  4 ++--
>  .../devicetree/bindings/interrupt-controller/open-pic.txt |  5 ++---
>  Documentation/devicetree/bindings/net/ethernet.txt        |  9 ++++++---
>  Documentation/devicetree/bindings/powerpc/fsl/cpus.txt    |  6 +++---
>  Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt |  2 +-
>  .../devicetree/bindings/powerpc/fsl/srio-rmu.txt          |  4 ++--
>  Documentation/devicetree/bindings/powerpc/fsl/srio.txt    |  3 ++-
>  Documentation/devicetree/booting-without-of.txt           |  2 +-
>  Documentation/devicetree/usage-model.txt                  |  2 +-
>  Documentation/xtensa/mmu.txt                              |  6 +++---
>  19 files changed, 46 insertions(+), 48 deletions(-)

Applied.
