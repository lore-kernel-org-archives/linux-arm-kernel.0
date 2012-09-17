From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 17 Sep 2012 11:19:09 +0200
Subject: [PATCH 02/34] ASoC: mx27vis: retrieve gpio numbers from
 platform_data
In-Reply-To: <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACKLOr2NcTs-nHO2JXSdAQuwcnJau1jMuz2LB5yxXNJcf4PY2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,
thank you for your patch.


On 17 September 2012 07:34, Shawn Guo <shawn.guo@linaro.org> wrote:
> Rather than including mach/iomux-mx27.h to define gpio numbers and set
> up the pins, the patch moves all these into machine code and has the
> gpio numbers passed to driver via platform_data.  As the result, we
> can remove the mach/iomux-mx27.h inclusion from driver.

In fact, this even solves a BUG related to the external amp GPIOs not
being registered.

Acked-By: Javier Martin <javier.martin@vista-silicon.com>

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
