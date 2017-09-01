From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Sep 2017 09:31:29 -0500
Subject: [PATCH 3/3] arm64: dts: realtek: Add watchdog node for RTD1295
In-Reply-To: <20170828113532.32627-4-afaerber@suse.de>
References: <20170828113532.32627-1-afaerber@suse.de>
 <20170828113532.32627-4-afaerber@suse.de>
Message-ID: <20170901143129.b3rzi7waqc3sz32j@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 01:35:31PM +0200, Andreas F?rber wrote:
> Add the watchdog node to the RTD1295 Device Tree.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Depends on the pending clock nodes patch.
>  
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
