From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 14:02:18 -0600
Subject: [PATCH v2 3/5] ARM: davinci_all_defconfig: enable iio and ADS7950
In-Reply-To: <3c4f8952-0a64-fc49-bd87-452dbbf7a946@ti.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
 <1483677228-2325-4-git-send-email-david@lechnology.com>
 <cb9455bc-2658-9826-823b-2aa845237fed@ti.com>
 <01ec2c94-46e0-3534-94e8-bd92f78b70ec@lechnology.com>
 <b29c37b2-382c-dbab-966b-4463e3127676@ti.com>
 <3c4f8952-0a64-fc49-bd87-452dbbf7a946@ti.com>
Message-ID: <a8ecd4a3-65b9-1719-2d82-1266250dfac5@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 06:24 AM, Sekhar Nori wrote:
> On Wednesday 11 January 2017 01:53 PM, Sekhar Nori wrote:

>> I do remember I did not see these two modules did not get enabled in
>> .config after 'make davinci_all_defconfig'. Will check what I may have
>> missed.
>
> So IIO_TRIGGERED_BUFFER is not selected in my tree because I dont have
> the ADS7950 driver enabled. Same thing with IIO_BUFFER.
>
> Can you try this patch over my tree?

I've got it sorted now and I have sent a new patch.
