From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Jun 2013 11:03:40 -0400
Subject: [PATCH] arm: kirkwood: sheevaplug: move pinmux configs to the
 right devices
In-Reply-To: <1370381552-9498-1-git-send-email-gmbnomis@gmail.com>
References: <1370381552-9498-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130605150340.GO3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 11:32:32PM +0200, Simon Baatz wrote:
> When the pinmux mechanism was added in Kirkwood, the device driver
> core was not yet providing the possibility of attaching pinmux
> configurations to all devices, drivers had to do it explicitly, and
> not all drivers were doing this.
> 
> Now that the driver core does that in a generic way, it makes sense to
> attach the pinmux configuration to their corresponding devices.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
> 
> Hi,
> 
> the patch series by Thomas to move the pinmux configs was prepared in
> parallel to the dts files for Sheevaplug.  Here is the corresponding
> patch in order to adapt these files as well.
> 
> - Simon
> 
>  arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi |   16 ++++++----------
>  arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts   |   21 ++++++++++++---------
>  arch/arm/boot/dts/kirkwood-sheevaplug.dts         |   18 ++++++++----------
>  3 files changed, 26 insertions(+), 29 deletions(-)

Applied to mvebu/dt with Thomas' Reviewed-by.

thx,

Jason.
