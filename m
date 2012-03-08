From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 08 Mar 2012 17:18:36 +0530
Subject: [PATCH v2 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
In-Reply-To: <m2pqcoihhu.fsf@bob.laptop.org>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>	<4F476228.7060607@ti.com>
 <4F54714E.6080805@ti.com>	<4F57312E.4080104@ti.com>
 <m2pqcoihhu.fsf@bob.laptop.org>
Message-ID: <4F589C94.9010601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Wednesday 07 March 2012 08:29 PM, Chris Ball wrote:
> Hi Rajendra,
>
> On Wed, Mar 07 2012, Rajendra Nayak wrote:
>>> Chris, Ping. I am basing my DT support patches on top of these cleanups.
>>> Would be great if you can have a look and pull them in.
>>
>> Chris, just realized the last two requests from me to get this merged
>> weren't addressed to you directly, but instead you were copied.
>> Resending with you in 'To', hope this lands in your inbox :)
>
> Sorry for the delay, thanks for the ping; I've pushed these to mmc-next
> for 3.4 now.

There's just one other cleanup patch here [1] to convert all pr_* prints
in the driver to dev_*. Would be great if you can pick that as well.

Thanks,
Rajendra

[1] http://marc.info/?l=linux-mmc&m=132999677405098&w=3

>
> Thanks,
>
> - Chris.
