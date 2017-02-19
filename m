From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 19 Feb 2017 01:01:36 +0100
Subject: [PATCH] DTS: Linksys Board: Add default trigger for sata led
In-Reply-To: <20170218141213.GK25924@io.lakedaemon.net>
References: <1487364137-3008-1-git-send-email-ansuelsmth@gmail.com>
 <20170218141213.GK25924@io.lakedaemon.net>
Message-ID: <a2fb4893-b890-3fa9-655c-fb0723d98048@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 18.02.2017 um 15:12 schrieb Jason Cooper:
> On Fri, Feb 17, 2017 at 09:42:17PM +0100, Ansuel Smith wrote:
>> In others board we have the sata led set to funcion with the sata led trigger by default.
>> This patch makes the same for these board that have sata led but disabled by not associating it to any trigger
> 
> Please line wrap the commit message.

The subject could also use some love, like mentioning "ARM:" and
"armada" and dropping "Board". Compare git log --oneline.

Regards,
Andreas

>  Other than that,
> 
>>
>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> thx,
> 
> Jason.
> 
>> ---
>>  arch/arm/boot/dts/armada-385-linksys-caiman.dts | 1 +
>>  arch/arm/boot/dts/armada-385-linksys-cobra.dts  | 1 +
>>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts   | 1 +
>>  3 files changed, 3 insertions(+)

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
