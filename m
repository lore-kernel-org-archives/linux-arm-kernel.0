From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 05 Sep 2012 11:23:58 +0300
Subject: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
 <5044C2DD.5000705@ti.com> <504578B3.3090804@ti.com> <5045D557.30404@ti.com>
 <79CD15C6BA57404B839C016229A409A83EAA7C99@DBDE01.ent.ti.com>
Message-ID: <50470C1E.7090300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/05/2012 09:11 AM, Hiremath, Vaibhav wrote:
>> Not yet, but we discussed that with Peter and since he does have these
>> patches for DT, he'll be able to test your series with the McBSP changes.
>>
> 
> Great.

With his series and your patch for omap-hwmod audio was probing and working on
OMAP3/4/5 without issues.

> 
>> I still want to update a couple of DTS to test that on some other IPs.
>>
> 
> Ohh ok. Please let me know if I can help you here by any means.
> I am equipped with AM37xEVM, BeagleBoard and Panda.

You can try this series and your patch on top of linux-next on Panda. Not all
patches are in which needed for BeagleBoard at the moment.

-- 
P?ter
