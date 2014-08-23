From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Sat, 23 Aug 2014 14:24:33 +0200
Subject: [PATCH 7/7] ARM: meson: update documentation (uart, timer and
 vendors)
In-Reply-To: <1408272594-10814-8-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-8-git-send-email-carlo@caione.org>
Message-ID: <53F88801.4050300@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.08.2014 12:49, schrieb Carlo Caione:
> New UART and timer bindings are documented. A new vendor is added to the
> vendors list.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++++++++++++
>  .../devicetree/bindings/timer/amlogic,meson6-timer.txt  | 16 ++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
>  3 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
[...]
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..5cf0618 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -14,6 +14,7 @@ allwinner	Allwinner Technology Co., Ltd.
>  altr	Altera Corp.
>  amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
>  amd	Advanced Micro Devices (AMD), Inc.
> +amlogic	Amlogic, Inc.
>  ams	AMS AG
>  amstaos	AMS-Taos Inc.
>  apm	Applied Micro Circuits Corporation (APM)

Sorry, here's the vendor prefix I was asking about. Please split it off
into its own patch and best order it before the first use.

Documentation of SoC and board seem to be indeed missing though.

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
