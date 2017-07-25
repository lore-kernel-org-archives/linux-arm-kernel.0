From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Tue, 25 Jul 2017 11:17:00 +0100
Subject: [PATCH v4 06/12] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <20170724204928.29505-7-robert.jarzmik@free.fr>
References: <20170724204928.29505-1-robert.jarzmik@free.fr>
 <20170724204928.29505-7-robert.jarzmik@free.fr>
Message-ID: <20170725101700.q4wrhl5klhn5amee@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 10:49:22PM +0200, Robert Jarzmik wrote:
> The WM9705, WM9712 and WM9713 are highly integrated codecs, with an
> audio codec, DAC and ADC, GPIO unit and a touchscreen interface.
> 
> Historically the support was spread across drivers/input/touchscreen and
> sound/soc/codecs. The sharing was done through ac97 bus sharing. This
> model will not withstand the new AC97 bus model, where codecs are
> discovered on runtime.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v3:
>  - added a "depends on AC97_BUS_NEW" Kconfig statement
>  - added default values for wm9705, wm9712 per Charles's comment
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
