From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Mar 2013 21:26:13 +0100
Subject: [PATCH 2/2] arm: sunxi: rename clock compatible strings
In-Reply-To: <1364351958-14503-3-git-send-email-emilio@elopez.com.ar>
References: <1364351958-14503-1-git-send-email-emilio@elopez.com.ar>
 <1364351958-14503-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <515355E5.3020804@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2013 03:39, Emilio L?pez a ?crit :
> During the introduction of the Allwinner SoC platforms, sunxi was
> initially meant as a generic name for all the variants of the Allwinner
> SoC.
> 
> It was ok at the time of the support of only the A10 and A13 that
> look pretty much the same; but it's beginning to be troublesome with
> the future addition of the Allwinner A31 (sun6i) that is quite
> different, and would introduce some weird logic, where sunxi would
> actually mean in some case sun4i and sun5i but without sun6i...
> 
> Moreover, it makes the compatible strings naming scheme not consistent
> with other architectures, where usually for this kind of compability, we
> just use the oldest SoC name that has this IP, so let's do just this.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Applied,
Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
