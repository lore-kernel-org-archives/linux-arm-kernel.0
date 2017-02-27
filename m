From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 08:49:11 +0100
Subject: [PATCH 1/9] ARM: dts: sun8i: add device tree for Lichee Pi Zero
 with Dock
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Message-ID: <20170227074910.hdsge4qhbqqufe36@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 08:30:21PM +0800, Icenowy Zheng wrote:
> Lichee Pi Zero features a dock, which adds some functions, and should be
> soldered with the core board of Lichee Pi Zero.
> 
> Add support for the dock as a new dts, as soldering is needed to make
> the dock usable and there's functions enabled on the dock that is
> unavailable at the 2.54mm pins of the core board.
> 
> Currently no new feature on core board is available in the mainline
> kernel, so the dock dt file only includes the core board device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

How does that relate to the rest of the serie, which seems to be about
the audio on V3s?

This should be clarified in a cover letter, but you know that already.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/b2e78d22/attachment.sig>
