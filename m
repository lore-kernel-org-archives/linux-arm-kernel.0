From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:26:34 +0000
Subject: [PATCH 02/14] regulator: axp20x: name voltage ramping define
 properly
In-Reply-To: <66ac03ac0e34e196e0469927c0feb3c98bc35837.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <66ac03ac0e34e196e0469927c0feb3c98bc35837.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181128092634.GX4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The current axp20x names the ramping register 'scal' which probably
> means scaling. Since the register really has nothing to do with
> scaling, but really is the voltage ramp we rename it appropriately.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  include/linux/mfd/axp20x.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This is clearly not a regulator patch.

Please change the subject line to "mfd", 

Once changed you can add my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
