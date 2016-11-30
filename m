From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 14:37:38 -0600
Subject: [PATCH 3/3] arm64: dts: r8a7796: Add CAN FD support
In-Reply-To: <1479903288-2009-1-git-send-email-chris.paterson2@renesas.com>
References: <1479903288-2009-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20161130203738.qi4y6c3nycxa5umu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 12:14:48PM +0000, Chris Paterson wrote:
> Adds CAN FD controller node for r8a7796.
> 
> Based on a patch for r8a7795 by Ramesh Shanmugasundaram.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 ++++++-----
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 24 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
