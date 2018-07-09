From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 9 Jul 2018 19:16:32 +0200
Subject: [PATCH v2 1/4] drm/panel: simple: Add support for Rocktech
 RK070ER9427 LCD panel
In-Reply-To: <20180607134648.2902-1-jagan@amarulasolutions.com>
References: <20180607134648.2902-1-jagan@amarulasolutions.com>
Message-ID: <20180709171632.GG26651@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 07:16:48PM +0530, Jagan Teki wrote:
> This adds support for the Rocktech Display Ltd. RK070ER9427
> 800(RGB)x480 TFT LCD panel, which can be supported by the
> simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2:
> - collect Rob r-w-b tag
> 
>  .../display/panel/rocktech,rk070er9427.txt         | 25 ++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt

checkpatch warns about the rocktech vendor prefix not being documented.
Can you send a patch which adds it to

	Documentation/devicetree/bindings/vendor-prefixes.txt

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/b788ae73/attachment.sig>
