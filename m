From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 16:51:59 +0100
Subject: [PATCH v2 1/9] drivers: pinctrl: add driver for Allwinner H5 SoC
In-Reply-To: <20170126154859.55855-2-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-2-icenowy@aosc.xyz>
Message-ID: <20170127155159.3e3j6xwf7nis6vtp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48:51PM +0800, Icenowy Zheng wrote:
> Based on the Allwinner H5 datasheet and the pinctrl driver of the
> backward-compatible H3 this introduces the pin multiplex assignments for
> the H5 SoC.
> 
> H5 introduced some more pin functions (e.g. three more groups of TS
> pins, and one more groups of SIM pins) than H3.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/3ef8ed53/attachment.sig>
