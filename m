From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:52:37 -0500
Subject: [PATCHv2 2/5] arm64: dts: allwinner: a64: Add watchdog
In-Reply-To: <20180315162510.11669-3-harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-3-harald@ccbib.org>
Message-ID: <20180318031909.u5s4ttzxmta7e4sa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:25:07PM +0000, Harald Geyer wrote:
> Add a watchdog node for the A64, automatically enabled on all boards.
> Since the device is compatible with an existing driver, we only reserve
> a new compatible string to be used together with the fall back.
> Tested on Olimex Teres-I.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> changes since v1:
>  * add and use a specific compatible string
> 
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 6 ++++--
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi            | 7 +++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
