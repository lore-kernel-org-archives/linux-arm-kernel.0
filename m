From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 14:53:41 -0800
Subject: [PATCH 2/9] pinctrl: sunxi: rename sun7i-a20 driver to
 sunxi-a20-r40
In-Reply-To: <20170217173722.6477-3-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
 <20170217173722.6477-3-icenowy@aosc.xyz>
Message-ID: <20170221225341.cknbz34xji2d3jkp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 18, 2017 at 01:37:15AM +0800, Icenowy Zheng wrote:
> The new R40 SoC come with a largely similar version of the pin
> controller in A20.
> 
> Rename the driver, in order to extend it with R40 support.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I'm not too fond of renaming this. This is going to be renamed over
and over again, will break the configurations every time.

We're not doing that for the other drivers, I'm not sure why we would
need it specifically for the pinctrl drivers.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/51ebde1e/attachment.sig>
