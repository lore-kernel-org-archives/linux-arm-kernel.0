From: romain.perier@collabora.com (Romain Perier)
Date: Wed, 26 Apr 2017 09:17:50 +0200
Subject: [PATCH] serial: imx: Enable RTSD only when needed
In-Reply-To: <CAOMZO5Anz_C-pxPke_mqCtD_D9LBxTRWSk5fAZrr6KaMeMZGqQ@mail.gmail.com>
References: <20170412133015.23185-1-romain.perier@collabora.com>
 <CAOMZO5Anz_C-pxPke_mqCtD_D9LBxTRWSk5fAZrr6KaMeMZGqQ@mail.gmail.com>
Message-ID: <77d20ce7-d953-6de1-330a-b7a29811ca8f@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,


Le 12/04/2017 ? 15:38, Fabio Estevam a ?crit :
> On Wed, Apr 12, 2017 at 10:30 AM, Romain Perier
> <romain.perier@collabora.com> wrote:
>> From: Nandor Han <nandor.han@ge.com>
>>
>> Currently, this IRQ is always enabled. Some devices might mux these pins
>> to other I/Os, like I2C. This could lead to spurious interrupts.
>>
>> This commit makes this IRQ optional, by using the field have_rtscts.
>>
>> Signed-off-by: Nandor Han <nandor.han@ge.com>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

No more feedback on this patch ?

Regards,
Romain
