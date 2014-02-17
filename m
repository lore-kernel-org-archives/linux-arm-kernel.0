From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 17 Feb 2014 16:34:13 -0600
Subject: [PATCH v4 2/4] DT: Vendor prefixes: Add ricoh, ssi and synology
In-Reply-To: <1392673537-17308-3-git-send-email-klightspeed@killerwolves.net>
References: <1392673537-17308-1-git-send-email-klightspeed@killerwolves.net>
 <1392673537-17308-3-git-send-email-klightspeed@killerwolves.net>
Message-ID: <20140217223413.GB31116@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 07:45:35AM +1000, klightspeed at killerwolves.net wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The following patches make use of vendor names ricoh, ssi and
> synology.  Add them to the vendor prefix list.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
> v2:
> Use stock ticker for Ricoh as vendor name
> s/Richoh/Ricoh/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 40ce2df..8427681 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -72,6 +72,7 @@ ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
>  realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
> +ricoy	Ricoh Co. Ltd.
>  rockchip	Fuzhou Rockchip Electronics Co., Ltd
>  samsung	Samsung Semiconductor
>  sbs	Smart Battery System
> @@ -79,11 +80,13 @@ schindler	Schindler
>  sil	Silicon Image
>  silabs	Silicon Laboratories
>  simtek
> +sii	Seiko Instruments, Inc.
>  sirf	SiRF Technology, Inc.
>  snps 	Synopsys, Inc.
>  st	STMicroelectronics
>  ste	ST-Ericsson
>  stericsson	ST-Ericsson
> +synology	Synology, Inc.

Oh, great!  Looks like this one is added (see my comment on patch 1).
I'm wondering if 'qnap' should be added as well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
