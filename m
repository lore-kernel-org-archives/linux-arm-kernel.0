From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 30 Oct 2017 21:44:38 +0200
Subject: [PATCH 0/2] ARM: OMAP3: fix boot regression for N9
In-Reply-To: <20171030161950.GA7339@atomide.com>
References: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
 <20171030161950.GA7339@atomide.com>
Message-ID: <6baaa6fd-d059-d2f7-fdcc-f42d2160da45@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/17 18:19, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [171030 02:13]:
>> Hi,
>>
>> N9 boot is apparently broken with mainline, caused by some recent
>> changes to TI clock drivers. The reason for failing boot is effectively
>> missing hwmod data piece for MMC3, so add this in place. The CM
>> related fix is also needed to properly handle idlest functionality
>> on OMAP3; currently this is mostly masked but will cause issues in
>> some places.
> 
> Thanks applying both into omap-for-v4.14/fixes. If these don't make
> it to v4.14, these can always be requested for stable releases as
> needed as specified in Documentation/process/stable-kernel-rules.rst.

Yeah, really sorry about the delay but was kind of out of my hands this 
time. Hopefully my email issues have been solved for now and this won't 
happen again.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
