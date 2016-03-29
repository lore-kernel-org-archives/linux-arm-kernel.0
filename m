From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 29 Mar 2016 22:45:18 +0200
Subject: [PATCH v4 3/8] Documentation: devicetree: rockchip: Document
 GeekBox
In-Reply-To: <31070685.TnxqGeNupO@diego>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <1458136727-32075-4-git-send-email-afaerber@suse.de>
 <31070685.TnxqGeNupO@diego>
Message-ID: <56FAE95E.6060900@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.03.2016 um 22:13 schrieb Heiko St?bner:
> Am Mittwoch, 16. M?rz 2016, 14:58:41 schrieb Andreas F?rber:
>> Use "geekbuying,geekbox" compatible string.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> I've folded this patch into the geekbox dts patch, carrying Rob's Ack for the 
> binding over.

Either you just made a mistake in my name or
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/submitting-patches.txt
needs an update. It clearly says:

"1) The Documentation/ portion of the patch should be a separate patch."

That's why I always do it this way.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
