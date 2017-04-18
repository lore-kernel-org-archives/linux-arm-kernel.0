From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 18 Apr 2017 17:03:04 +0900
Subject: [PATCH v2 2/3] drm/panel: s6e3ha2: Add support for s6e3hf2 panel
 on TM2e board
In-Reply-To: <5b3031ca-2847-fbc0-36f3-7e0a6cd3e0b3@samsung.com>
References: <1492408934-22096-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170417060219epcas5p4726fab1b7a58ac3d832e2be86873a37d@epcas5p4.samsung.com>
 <1492408934-22096-3-git-send-email-hoegeun.kwon@samsung.com>
 <5b3031ca-2847-fbc0-36f3-7e0a6cd3e0b3@samsung.com>
Message-ID: <58F5C838.7080807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2017? 04? 18? 14:55? Andrzej Hajda ?(?) ? ?:
> On 17.04.2017 08:02, Hoegeun Kwon wrote:
>> This patch supports TM2e panel and the panel has 1600x2560 resolution
>> in 5.65" physical.
>>
>> This identify panel type with compatibility string, also invoke
>> display mode that matches the type. So add the check code for s6e3ha2
>> compatibility and s6e3hf2 type and select the drm_display_mode of
>> default and edge type.
>>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> 
>  --
> Regards
> Andrzej
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
