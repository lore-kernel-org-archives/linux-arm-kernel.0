From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Aug 2013 13:13:25 -0600
Subject: [PATCH 1/2] extcon: palmas: Added a new compatible type *ti,
 palmas-usb-vid*
In-Reply-To: <1376372241-15573-1-git-send-email-kishon@ti.com>
References: <1376302675-15795-1-git-send-email-kishon@ti.com>
 <1376372241-15573-1-git-send-email-kishon@ti.com>
Message-ID: <520A8555.10401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 11:37 PM, Kishon Vijay Abraham I wrote:
> The Palmas device contains only a USB VID detector, so added a
> compatible type *ti,palmas-usb-vid*. Dint remove the existing compatible

s/Dint/Didn't/

> diff --git a/Documentation/devicetree/bindings/extcon/extcon-twl.txt b/Documentation/devicetree/bindings/extcon/extcon-twl.txt

>  PALMAS USB COMPARATOR
>  Required Properties:
> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
> + - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb" or
> +   "ti,palmas-usb-vid".

So are ti,palmas-usb and ti,twl6035-usb full EHCI controllers then?
