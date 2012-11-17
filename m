From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Sat, 17 Nov 2012 23:15:18 +0530
Subject: [PATCHv3] i2c: omap: Move the remove constraint
In-Reply-To: <20121116142006.GG7313@pengutronix.de>
References: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
 <20121116142006.GG7313@pengutronix.de>
Message-ID: <CAM=Q2cuX4j1uELVOurtSuDfN3CtEn3VejYUdMS24yaO7ru=Mdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 7:50 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Nov 15, 2012 at 02:19:21PM +0530, Shubhrajyoti D wrote:
>> Currently we just queue the transfer and release the
>> qos constraints, however we do not wait for the transfer
>> to complete to release the constraint. Move the remove
>> constraint after the bus busy as we are sure that the
>> transfers are completed by then.
>>
>> Acked-by: Jean Pihet <j-pihet@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Applied to for-next. Please let me know if it should go to for-current.

I feel for-next should be fine.

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
