From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 8 Nov 2010 17:52:40 -0600
Subject: [PATCH 2/6] OMAP3: hwmod data: Add mmu for iva2 and isp
In-Reply-To: <4CD88251.4060400@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-3-git-send-email-omar.ramirez@ti.com>
	<4CD5A96D.1000806@ti.com>
	<AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
	<4CD88251.4060400@ti.com>
Message-ID: <AANLkTimexv8gb0HtDKf28w_1GWik6TtZSYZGpWQUVHyk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 8, 2010 at 5:05 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>>>> Add mmu hwmod data for iva2 and isp.
>>>
>>> s/iva2/iva/
>>
>> Where this terminology can be found? I'm basing this naming on what
>> was there or TRM. For omap3 there is no such thing as iva, it is iva2.
>
> IVA2 means IVA v2, before we had an IVA (v1) then IVA v1.1...
>
> The goal is to use the same name for the IP with similar functionality
> across OMAPs version in order to have generic code in the driver.
>
> IVA, IVA2, IVAHD are all doing similar things, so the only way to identify
> the same functionality is by using the same name.
> Thanks to the rev field, you can differentiate the various version during
> device creation.
> That will allow you to query the hwmod on every version of OMAPs using the
> same "iva" name. Otherwise you will have to use the cpu_is_omap_XXX to
> select iva, iva2 or ivahd depending of the SoC.
>
> Does that make sense to you?

That makes sense, thanks for the explanation.

Omar
