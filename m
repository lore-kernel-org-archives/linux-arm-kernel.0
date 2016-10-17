From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Oct 2016 20:04:52 +0200
Subject: [PATCH] ARM: dts: sunxi: Add cpu-supply for Olimex A20 EVB
In-Reply-To: <20161015152340.43315-1-manu@bidouilliste.com>
References: <20161015152340.43315-1-manu@bidouilliste.com>
Message-ID: <20161017180452.etevnvhr7ywbxmuh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 15, 2016 at 05:23:40PM +0200, Emmanuel Vadot wrote:
> sun7i-a20-olimex-som-evb.dts doesn't contain cpu-supply needed for
> voltage-scaling with cpufreq-dt so define it.
> The default voltages are defined in sun7i-a20.dtsi.
> 
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161017/3aebd1db/attachment-0001.sig>
