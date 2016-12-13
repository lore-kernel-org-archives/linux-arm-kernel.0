From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 20:13:50 +0100
Subject: [PATCH 5/6] ARM: dts: sun8i: set cpu-supply in reference tablet
 DTSI
In-Reply-To: <20161213152252.53749-6-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-6-icenowy@aosc.xyz>
Message-ID: <20161213191350.dsybyjfuocrvx4zj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 11:22:51PM +0800, Icenowy Zheng wrote:
> All reference design A33 tablets uses DCDC2 of AXP223 as the power
> supply of the Cortex-A7 cores.
> 
> Set the cpu-supply in the DTSI of sun8i reference tablets.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/7c630f82/attachment.sig>
