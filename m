From: robherring2@gmail.com (Rob Herring)
Date: Thu, 6 Feb 2014 09:49:10 -0600
Subject: [PATCH 2/4] DT: Vendor prefixes: Add ricoh, ssi and synology
In-Reply-To: <1391634309-3123-3-git-send-email-andrew@lunn.ch>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-3-git-send-email-andrew@lunn.ch>
Message-ID: <CAL_JsqKKWW6_EaE25JgoUUMCDOwWDwMnZPjBXYo-bT8ws3GdjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 5, 2014 at 3:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> The following patches make use of vendor names ricoh, ssi and
> synology.  Add them to the vendor prefix list.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 3f900cd51bf0..1629e8f33578 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -69,6 +69,7 @@ ralink        Mediatek/Ralink Technology Corp.
>  ramtron        Ramtron International
>  realtek Realtek Semiconductor Corp.
>  renesas        Renesas Electronics Corporation
> +ricoh  Richoh Co. Ltd.

This should be "ricoy" to follow the stock ticker symbol.

Rob
