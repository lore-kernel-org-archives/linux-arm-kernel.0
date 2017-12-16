From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Dec 2017 12:34:14 -0600
Subject: [PATCH 2/9] ARM: dts: Add generic ti, sysc compatible in
 addition to the custom ones
In-Reply-To: <20171215180900.3243-3-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-3-tony@atomide.com>
Message-ID: <20171216183414.24ycqj7q2beehiiq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 10:08:53AM -0800, Tony Lindgren wrote:
> Otherwise we cannot use generic OF_DEV_AUXDATA match without listing
> all the compatibles separately for OF_DEV_AUXDATA. Let's also update the
> binding accordingly.

Your subject has a space in "ti,sysc".

> Let's also fix omap4.dtsi to use "ti,sysc-omap4-sr" compatible as we
> have documented in the binding. This was not noticed earlier as we're
> still probing SmartReflex driver with platform data.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
>  arch/arm/boot/dts/dra7.dtsi                       |  4 ++--
>  arch/arm/boot/dts/omap4.dtsi                      | 20 ++++++++++----------
>  3 files changed, 13 insertions(+), 12 deletions(-)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
