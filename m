From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 09 Sep 2011 09:51:53 +0530
Subject: [PATCH 08/25] OMAP4: PM: Keep static dep between MPUSS-EMIF and
	MPUSS-L3 and DUCATI-L3
In-Reply-To: <87ehzqhpsk.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-9-git-send-email-santosh.shilimkar@ti.com>
	<87ehzqhpsk.fsf@ti.com>
Message-ID: <4E699461.9070609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011 11:36 PM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> As per OMAP4430 TRM, the dynamic dependency between MPUSS ->  EMIF
>> and MPUSS ->  L3* and DUCATI ->  L3 *clockdomains is enable by default.
>> Refer register CM_MPU_DYNAMICDEP description for details.
>>
>> But these dynamic dependencies doesn't work as expected. The hardware
>> recommendation is to keep above dependencies.
>
> Minor nit on changelog wording...
>
> The use of "above dependencies" here is a bit confusing, since the only
> thing refered to above are dynamic dependencies.
>
> I think this should be worked to be clear that what is being kept are
> the *static* dependencies (assuming I understand it correctly.)
>
Will mention about static deps.

>
>> Without this system locks up or randomly crashesh.
>
> Is 'crashesh' a particular kind of crash. maybe a silent one?  ;)
>
My typo made it special :)
Will fix it.

Regards
Santosh
