From: caesar.upstream@gmail.com (Caesar Wang)
Date: Wed, 22 Jun 2016 19:19:24 +0800
Subject: [PATCH v5 0/5] Thermal: Support for hardware-tracked trip points
In-Reply-To: <1466565939.2379.5.camel@intel.com>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
 <57689B82.3000902@gmail.com> <1466565939.2379.5.camel@intel.com>
Message-ID: <576A743C.7080401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2016?06?22? 11:25, Zhang Rui wrote:
> On ?, 2016-06-21 at 09:42 +0800, Caesar Wang wrote:
>> Do you have other ideas for the following patches? :-)
>> Even if only took two weeks feel after a long time.
>>
>> 9157919 New          [v5,1/5] thermal: Add support for hardware-
>> tracked trip points
>> 9157917 New          [v5,2/5] thermal: of: implement .set_trips for
>> device tree thermal zones
>> 9161129 New          [v5.1,3/5] thermal: streamline get_trend
>> callbacks
>> 9157929 New          [v5,4/5] thermal: bang-bang governor: act on
>> lower trip boundary
>> 9157925 New          [v5,5/5] thermal: rockchip: add the set_trips
>> function
>> ---
>>
> I have no objections to this patch set, except one change in patch 1/5.
> But as this also touches of_thermal and rockchip thermal driver. I'd
> leave this patch set for Eduardo to review and take.
> BTW, Eduardo is traveling recently, so you may still need to wait some
> time.

Okay, thanks for your reminder. and sorry for the noise.:-)

-
Caesar

>
> Thanks,
> rui
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
