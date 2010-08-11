From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 14:01:22 +0300
Subject: [PATCH v3 8/9] omap: hsmmc: split mmc23 power control
In-Reply-To: <4C6280DA.70205@nokia.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-9-git-send-email-ohad@wizery.com>
	<4C6275F3.6030108@nokia.com> <4C6280DA.70205@nokia.com>
Message-ID: <AANLkTi=MB+021B+TRu6x1frM5=OB9p-wS1G441bhgiWj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 1:52 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> On 08/11/2010 01:05 PM, Hunter Adrian (Nokia-MS/Helsinki) wrote:
>>
>> Ohad Ben-Cohen wrote:
>>>
>>> Prepare for mmc3 regulator power control by splitting the power
>>> control functions of mmc2 and mmc3, and expecting mmc3 to have
>>> a single, dedicated, regulator support.
>>
>> Why? ?Can't the controller be connected to an eMMC with 2 power
>> supplies? ?At a glance, it is not obvious why this patch is needed.
>>
> I agree with Adrian. This patch is not required at all.
>

Thanks guys, I'll check it out.

I'm about to leave until e/o August and I still have to sort out some
stuff, so I might not respond right away, but please send any comments
you may still have.
