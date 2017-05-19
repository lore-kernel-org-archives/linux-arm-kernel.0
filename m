From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 20:03:30 +0200
Subject: [RFC PATCH 07/11] drm: sun4i: add support for the TV encoder in
 H3 SoC
In-Reply-To: <20170517164354.16399-8-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-8-icenowy@aosc.io>
Message-ID: <20170519180330.7hpfkdqk3r2x3kn5@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 12:43:50AM +0800, Icenowy Zheng wrote:
> Allwinner H3 features a TV encoder similar to the one in earlier SoCs,
> but with some different points about clocks:
> - It has a mod clock and a bus clock.
> - The mod clock must be at a fixed rate to generate signal.

Why?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/f6a71f40/attachment.sig>
