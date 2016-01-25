From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jan 2016 13:40:07 -0600
Subject: [PATCH v2 2/2] arm64: dts: Add support for Juno r2 board
In-Reply-To: <1453734849-13790-2-git-send-email-sudeep.holla@arm.com>
References: <1453734849-13790-1-git-send-email-sudeep.holla@arm.com>
 <1453734849-13790-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160125194007.GA11111@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:14:09PM +0000, Sudeep Holla wrote:
> Juno r2 is identical to Juno r1 with Cortex A57 cores replaced by
> Cortex A72 cores.
> 
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm-boards   |  1 +
>  arch/arm64/boot/dts/arm/Makefile                   |  2 +-
>  .../boot/dts/arm/{juno-r1.dts => juno-r2.dts}      | 30 +++++++++++-----------
>  3 files changed, 17 insertions(+), 16 deletions(-)
>  copy arch/arm64/boot/dts/arm/{juno-r1.dts => juno-r2.dts} (87%)

Acked-by: Rob Herring <robh@kernel.org>
