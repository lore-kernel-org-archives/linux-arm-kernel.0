From: randy.li@rock-chips.com (Randy Li)
Date: Tue, 9 May 2017 09:16:31 +0800
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <12996903.t3AZceNVOh@diego>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
 <12996903.t3AZceNVOh@diego>
Message-ID: <b63475e9-21f6-5995-90b6-e0eeae8144ab@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/09/2017 12:27 AM, Heiko St?bner wrote:
> Am Mittwoch, 3. Mai 2017, 10:56:24 CEST schrieb Guillaume Tucker:
>> The ARM Mali Midgard GPU kernel driver is only available
>> out-of-tree and is not going to be merged in its current form.
>> However, it would be useful to have its device tree bindings
>> merged.  In particular, this would enable distributions to create
>> working driver packages (dkms...) without having to patch the
>> kernel.
>>
>> The bindings for the earlier Mali Utgard GPU family have already
>> been merged, so this is essentially the same scenario but for
>> newer GPUs (Mali-T604 ~ Mali-T880).
>>
>> This series of patches first imports the bindings from the latest
>> driver release with some clean-up then adds a gpu node for the
>> rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
>> Firefly, Veyron Minnie and Jerry boards using Mali kernel driver
>> r16p0 and r12p0 user-space binary.
I won't suggest such combine. We meet some problems at mali 400 serial.
I would suggest the kernel version would match the user library.
Also please notice there is rk3288w, the hardware version becomes r1p0.
> 
> The actual devicetree parts are all Rockchip-specific, so I guess I'll just
> pick up the whole series, including the binding doc, after the merge
> window if nobody complains before that :-)
> 
> 
> Heiko
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

-- 
Randy Li
