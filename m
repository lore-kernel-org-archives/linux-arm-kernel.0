From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Sep 2018 16:38:56 +0100
Subject: [PATCH] mfd: motorola-cpcap: Add audio-codec support
In-Reply-To: <20180829093104.GA22065@amd>
References: <20180829093104.GA22065@amd>
Message-ID: <20180910153856.GC28860@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Aug 2018, Pavel Machek wrote:

> From: Sebastian Reichel <sre@kernel.org>
>     
> Add support for the audio-codec node by converting from
> devm_of_platform_populate() to devm_mfd_add_devices().
>    
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
