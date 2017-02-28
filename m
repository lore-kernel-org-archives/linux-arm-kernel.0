From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Feb 2017 07:44:26 +0100
Subject: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
In-Reply-To: <20170227194054.51951-2-icenowy@aosc.xyz>
References: <20170227194054.51951-1-icenowy@aosc.xyz>
 <20170227194054.51951-2-icenowy@aosc.xyz>
Message-ID: <20170228064426.jsukm53ybaatpgyx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Allwinner SoCs from H3 (including H5, A64, etc) have a new version of
> thermal sensor, and needs a new driver for it.
> 
> Add such a driver.
> 
> Currently only H3 is supported, but other SoCs are easily to be
> supported by adding new formula and set the sensor number.
> 
> Signed-off-by: Ond?ej Jirman <megous@megous.com>
> [Icenowy: extend to support further multiple-sensor SoCs, change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

There's no need to create a new driver for that. This can be handled
by the GPADC driver we already have.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170228/e6309858/attachment.sig>
