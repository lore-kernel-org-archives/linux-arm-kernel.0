From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Mon, 3 Jul 2017 09:58:17 +0100
Subject: [PATCH v3 05/12] Input: wm97xx: split out touchscreen registering
In-Reply-To: <20170630194408.24978-6-robert.jarzmik@free.fr>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-6-robert.jarzmik@free.fr>
Message-ID: <20170703085817.fajdhhgamngxfnwp@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 09:44:01PM +0200, Robert Jarzmik wrote:
> wm97xx-core does several things in it initialization :
>  - touchscreen input device setup
>  - battery device creation
> 
> As the wm97xx is actually a multi-function device handling an audio
> codec, a touchscreen, a gpio block and an ADC, reshape the probing to
> isolate what is truly input/touchscreen specific from the remaining
> part.
> 
> This is only code shuffling, there is no functional change.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
