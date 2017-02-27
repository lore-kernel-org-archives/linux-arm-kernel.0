From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 15:39:13 +0100
Subject: [PATCH 1/8] ARM: sun8i: Fix the mali clock rate
In-Reply-To: <4830ced34cc83058f7cad123be67fecc624a99d6.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <4830ced34cc83058f7cad123be67fecc624a99d6.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170227143913.ld3rxwicjvjnrbgl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 05:39:15PM +0100, Maxime Ripard wrote:
> The Mali clock rate was improperly assumed to be 408MHz, while it was
> really 384Mhz, 408MHz being the "extreme" frequency, and definitely not
> stable.
> 
> Switch for the stable, correct frequency for the GPU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/6eed4658/attachment.sig>
