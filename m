From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Feb 2014 12:13:35 -0300
Subject: [RFC PATCH v4 4/8] staging: imx-drm: Document imx-hdmi device
 tree bindings
In-Reply-To: <1393338203-25051-5-git-send-email-p.zabel@pengutronix.de>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-5-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5AnXYEDB5PfQUNW_bY7ng8YkSYGK5y_Em04t6L-Eb2g+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:23 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> This patch adds device tree binding documentation for the HDMI transmitter
> on i.MX6.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../devicetree/bindings/staging/imx-drm/hdmi.txt   | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>
> diff --git a/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
> new file mode 100644
> index 0000000..7dcd673a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
> @@ -0,0 +1,53 @@
> +Device-Tree bindings for HDMI Transmitter
> +
> +HDMI Transmitter
> +================
> +
> +The LVDS Display Bridge device tree node contains up to two lvds-channel
> +nodes describing each of the two LVDS encoder channels of the bridge.

Copy and paste error? ;-)
