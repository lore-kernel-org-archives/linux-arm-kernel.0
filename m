From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 14:36:37 -0600
Subject: [PATCH 2/3] arm64: dts: r8a7796: Add CAN support
In-Reply-To: <1479903279-1950-1-git-send-email-chris.paterson2@renesas.com>
References: <1479903279-1950-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20161130203637.gbndehnhkzn7pz6x@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 12:14:39PM +0000, Chris Paterson wrote:
> Adds CAN controller nodes for r8a7796.
> 
> Based on a patch for r8a7795 by Ramesh Shanmugasundaram.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++++----
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 30 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
