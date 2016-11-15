From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 18:42:37 +0100
Subject: [PATCH v2 0/3] ARM: dts: sun7i: BPI-M1+ USB support
In-Reply-To: <20161115135106.438-1-wens@csie.org>
References: <20161115135106.438-1-wens@csie.org>
Message-ID: <20161115174237.ootkbvtfumt6mqy7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 09:51:03PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> These are the remaining patches of my BPI-M1+ fixes series from July.
> 
> Changes since v1:
> 
>   - Split out USB PHY enable patch.
> 
>   - Dropped custom OPP table. Tested the A20 default one with
>     cpufreq-ljt-stress-test and it seemed stable.
> 
>   - Dropped voltage range for cpu supply regulator to normal 1.0V ~ 1.4V.
> 
>   - Dropped pinmux setting for OTG ID pin.

Applied all three, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/a949c517/attachment.sig>
