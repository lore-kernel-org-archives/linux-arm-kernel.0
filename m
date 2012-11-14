From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 14 Nov 2012 16:55:34 +0530
Subject: [PATCH] i2c: omap: Move the remove constraint
In-Reply-To: <CAORVsuUxA=AhPowWqTWx5AfzU6R2Ny6OEhvDmtwUh8poh=UnGg@mail.gmail.com>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
 <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
 <20121114105734.GE5954@pengutronix.de>
 <CAORVsuUxA=AhPowWqTWx5AfzU6R2Ny6OEhvDmtwUh8poh=UnGg@mail.gmail.com>
Message-ID: <50A37FAE.9050004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 November 2012 04:33 PM, Jean Pihet wrote:
>>> Acked-by: Jean Pihet <j-pihet@ti.com>
>> >
>> > Since I just reverted the QoS patch, I suppose this gets merged into the
>> > original patch when resent?
> The best for now is to re-submit a new patch that moves the constraint
> release in the original code. Later the PM QoS patch will be applied
> on the new code base.
>
> What do you think? I can provide a patch if needed.
Will resubmit this.

> Regards,
> Jean
>
