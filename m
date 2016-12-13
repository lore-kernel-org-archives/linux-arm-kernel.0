From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Dec 2016 14:07:55 -0600
Subject: [PATCH 1/3] dt-bindings: arm: update Armada CP110 system
 controller binding
In-Reply-To: <1481632880-9198-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1481632880-9198-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1481632880-9198-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20161213200755.g4zkj4rxyzjd3as3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 01:41:18PM +0100, Thomas Petazzoni wrote:
> It turns out that in the CP110 HW block present in Marvell Armada
> 7K/8K SoCs, gatable clock n?18 not only controls SD/MMC, but also the
> GOP block. This commit updates the Device Tree binding for this piece
> of hardware accordingly.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/marvell/cp110-system-controller0.txt    | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
