From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 28 Nov 2016 11:42:18 +0100
Subject: [RFC PATCH] ARM: dts: sun8i: add simplefb node for H3
In-Reply-To: <20161128095900.27615-1-icenowy@aosc.xyz>
References: <20161128095900.27615-1-icenowy@aosc.xyz>
Message-ID: <20161128114218.14d2ed434802a20fa6b62023@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Nov 2016 17:59:00 +0800
Icenowy Zheng <icenowy@aosc.xyz> wrote:

> As there's currently a fork of U-Boot which provides simplefb support
> for H3, a simplefb node can be added to the device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> 
> I'm still not sure which pipeline should I use.
> 
> And, it seems that HDMI Slow Clock is not needed?
> 
> (seems that it's only for EDID, but simplefb won't use EDID)

So, I don't see how this may work.
How can the u-boot know the resolutions of the HDMI display device?

In other words: I have a new H3 board with the last u-boot and kernel.
I plug my (rather old or brand new) HDMI display device.
After powering on the system, I hope to get something on the screen.
How?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
