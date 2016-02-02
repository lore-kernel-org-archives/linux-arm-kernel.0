From: robh@kernel.org (Rob Herring)
Date: Tue, 2 Feb 2016 15:26:37 -0600
Subject: [PATCH 05/10] Documentation: dt: Tidy up the Marvell related files
In-Reply-To: <1454436468-4241-6-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160202212637.GA24562@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:07:43PM +0100, Gregory CLEMENT wrote:
> Over the last releases we have added more and more Marvell related binding
> directly in the arm directory. It's time to have our proper directory
> inside it, and move all the files in it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt          | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt     | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt        | 0
>  .../devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt        | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt        | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt          | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt    | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt      | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt  | 0
>  .../devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt     | 0
>  14 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt (100%)

Acked-by: Rob Herring <robh@kernel.org>
