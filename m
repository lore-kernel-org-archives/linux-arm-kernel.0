From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 7 Jun 2013 13:40:52 +0530
Subject: [PATCH 00/11] Convert GPIO Davinci to platform driver
In-Reply-To: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
Message-ID: <51B1958C.3050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Avinash,

On 5/22/2013 12:40 PM, Philip Avinash wrote:
> GPIO Davinci driver converted to platform driver to support DT booting.
> In this patch series
> - Cleaned gpio Davinci driver code with proper commenting style and appropriate
>   variable names.
> - Create platform driver for GPIO Davinci in da8xx and dm* platforms and removed
>   gpio related member updation in davinci_soc_info structure.
> - DT support added for da850 board and tested on da850 EVM.
> - Remove soc_info reference in the gpio davinci driver and start uses
>   gpiolib interface.

Can you please document which platforms this series was tested on and how?

Thanks,
Sekhar
