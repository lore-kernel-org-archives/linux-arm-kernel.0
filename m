From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 18 Jan 2018 16:28:58 +0800
Subject: [PATCH v3 01/12] iommu/rockchip: Prohibiat unbind and remove
In-Reply-To: <CAAFQd5B24j6OSStpYWiO-xfhH131mwNRk3=cEBakMpvsEkQ7wg@mail.gmail.com>
References: <20180117152542.26429-1-jeffy.chen@rock-chips.com>
 <20180117152542.26429-2-jeffy.chen@rock-chips.com>
 <CAAFQd5B24j6OSStpYWiO-xfhH131mwNRk3=cEBakMpvsEkQ7wg@mail.gmail.com>
Message-ID: <5A605ACA.7030207@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Thanks for your reply.

and just found i forgot to add iommu clocks for other rockchip 
platforms(rk3399 already has that)...will also do that in the next version.

On 01/18/2018 12:17 PM, Tomasz Figa wrote:
> On Thu, Jan 18, 2018 at 12:25 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> Removal the IOMMUs cannot be done reliably.
>
> nit: Perhaps "Removal of IOMMUs"?
>
ok
>>
>> This is similar to exynos iommu driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v3:
>> Also remove remove() and module_exit() as Tomasz suggested.
>>
>> Changes in v2: None
>>
>>   drivers/iommu/rockchip-iommu.c | 21 +--------------------
>>   1 file changed, 1 insertion(+), 20 deletions(-)
>
> nit: Typo in subject: s/Prohibiat/Prohibit/
>
ok, will do that.
> Otherwise,
>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>
> Best regards,
> Tomasz
>
>
>
