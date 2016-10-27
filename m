From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 27 Oct 2016 10:11:02 +0100
Subject: [PATCH 8/9] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161027091102.GG28180@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 09:41:46PM +0200, Robert Jarzmik wrote:
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

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
