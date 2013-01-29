From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Tue, 29 Jan 2013 10:48:46 +0100
Subject: [PATCH 2/2] drivers: net:ethernet: cpsw: add support for VLAN
In-Reply-To: <1359403945-28585-3-git-send-email-mugunthanvnm@ti.com>
References: <1359403945-28585-1-git-send-email-mugunthanvnm@ti.com>
 <1359403945-28585-3-git-send-email-mugunthanvnm@ti.com>
Message-ID: <1359452926.4336.1.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 01:42 +0530, Mugunthan V N wrote:
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -24,6 +24,8 @@ Required properties:
>  Optional properties:
>  - ti,hwmods            : Must be "cpgmac0"
>  - no_bd_ram            : Must be 0 or 1
> +- default_vlan         : Specifies Default VLAN for non tagged packets
> +                         ALE processing

This does not seem to be a property of the hardware. Could there be a
reasonable default for it?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
