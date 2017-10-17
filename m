From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Tue, 17 Oct 2017 20:50:51 +0200
Subject: [PATCH v4 0/6] K2G: Add QSPI support
In-Reply-To: <ebd85d99-431b-3f6d-4bdf-e7d47b81567c@gmail.com>
References: <20171003051925.8821-1-vigneshr@ti.com>
 <09cc0a61-3f73-4a10-2d67-32515a7da861@ti.com>
 <6f507813-388a-13e5-31ba-736b419744fa@gmail.com>
 <69beca0c-68a2-2d2c-d4a8-6f05a1fbc957@wedev4u.fr>
 <ebd85d99-431b-3f6d-4bdf-e7d47b81567c@gmail.com>
Message-ID: <012e14f4-1eb0-2641-feaa-5fc8f9028810@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/10/2017 ? 00:34, Marek Vasut a ?crit?:
> On 10/17/2017 12:29 AM, Cyrille Pitchen wrote:
>> Hi all,
>>
>> Le 16/10/2017 ? 11:28, Marek Vasut a ?crit?:
>>> On 10/16/2017 08:15 AM, Vignesh R wrote:
>>>>
>>>>
>>>> On Tuesday 03 October 2017 10:49 AM, Vignesh R wrote:
>>>>>
>>>>>
>>>>> This series adds support for Cadence QSPI IP present in TI's 66AK2G SoC.
>>>>> The patches enhance the existing cadence-quadspi driver to support
>>>>> loopback clock circuit, pm_runtime support and tweaks for 66AK2G SoC.
>>>>
>>>> Gentle ping on the series...
>>>
>>> It's IMO OK, Cyrille, can you pick it ?
>>>
>>
>> The series looks good to me too.
>>
>> Marek, could you please add you "Acked-by" or "Reviewed-by" tag for the
>> record in patchwork ? It will be automatically added when I use
>> "pwclient git-am -s" to merge the patches into the spi-nor/next branch.
> 
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> 

added Marek's "Acked-by" tags on the whole series and applied it into
the spi-nor/next branch of l2-mtd

Thanks!
