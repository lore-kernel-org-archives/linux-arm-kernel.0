From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Thu, 19 May 2011 15:09:33 +0530
Subject: [PATCH V4] OMAP3+: SR Layer Cleanup
In-Reply-To: <87wrhn9ic2.fsf@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
	<87wrhn9ic2.fsf@ti.com>
Message-ID: <BANLkTi=BryM-eEsTNcV5E51SnkuZaKsF9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 19, 2011 at 2:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> Shweta Gulati <shweta.gulati@ti.com> writes:
>
>> To set sr ntarget values ?for all volt_domain,
>> volt_table is retrieved by doing a look_up of 'vdd_name'
>> field from omap_hwmod but voltage domain pointer does not
>> belong to omap_hwmod and is not used anywhere else.
>> As a part of voltage layer and SR Layer clean up volt
>> pointer is removed from omap_hwmod and added in dev
>> attributes of SR.
>>
>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> Acked by: Nishanth Menon <nm@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Paul <paul@pwsan.com>
>
> As this isn't a consolidation/cleanup, I'm not going to push for 2.6.40,
> but with an ack from Benoit, I'll queue for 2.6.40+.
>
> Also it has some minor conflicts with some other SR cleanups I have
> queued for 2.6.40+. ?Please rebase on to my for_2.6.40/pm-misc branch.
Ok, I will rebase it to 2.6.40/pm-misc branch.
> Thanks,
>
> Kevin
>



-- 
Thanks,
Regards,
Shweta
