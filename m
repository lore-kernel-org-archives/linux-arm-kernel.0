From: cjb@laptop.org (Chris Ball)
Date: Fri, 07 Jun 2013 07:15:39 -0400
Subject: [PATCH v9 1/9] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <51B17AE7.4070403@ti.com> (Sekhar Nori's message of "Fri, 7 Jun
 2013 11:47:11 +0530")
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-2-git-send-email-mporter@ti.com>
 <51B17AE7.4070403@ti.com>
Message-ID: <878v2m5fz8.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 07 2013, Sekhar Nori wrote:
> + Chris since the patch has some davinci_mmc.c changes.
>
> Chris, Mark,
>
> On 3/6/2013 9:45 PM, Matt Porter wrote:
>> Move mach-davinci/dma.c to common/edma.c so it can be used
>> by OMAP (specifically AM33xx) as well.
>> 
>> Signed-off-by: Matt Porter <mporter@ti.com>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
> Can you please ack changes in mmc and sound respectively? I would like
> to take the patch for v3.11.

For davinci_mmc.c:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
