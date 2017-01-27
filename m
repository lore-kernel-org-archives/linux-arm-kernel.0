From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 16:55:30 +0100
Subject: [PATCH v2 4/9] arm: dts: sun8i: split Allwinner H3 .dtsi
In-Reply-To: <20170126154859.55855-5-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-5-icenowy@aosc.xyz>
Message-ID: <20170127155530.co72bqdx4fdhvy4g@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48:54PM +0800, Icenowy Zheng wrote:
> -		mmc0: mmc at 01c0f000 {
> +		mmc at 01c0f000 {

There's no point in removing the labels, and you can even use the
label-based syntax to reference them, instead of using the path.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/161b3269/attachment.sig>
