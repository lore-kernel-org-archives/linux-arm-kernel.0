From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 7 Mar 2016 20:25:31 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Clean up gpio-keys
 example
In-Reply-To: <CABxcv=kEDoP3_Q3OKh1rGJ3=nFxRydu7L7bv5C=bNbmXyFt8dQ@mail.gmail.com>
References: <1457375055-5544-1-git-send-email-afaerber@suse.de>
 <CABxcv=kEDoP3_Q3OKh1rGJ3=nFxRydu7L7bv5C=bNbmXyFt8dQ@mail.gmail.com>
Message-ID: <56DDD5AB.1090707@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 07.03.2016 um 19:34 schrieb Javier Martinez Canillas:
> On Mon, Mar 7, 2016 at 3:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices.
>>
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> Looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks. Quick summary for non-Rockchip reviewers:

This is a resend of: https://patchwork.kernel.org/patch/8513851/

To avoid future resends: https://patchwork.kernel.org/patch/8521501/

Rockchip arm64 cleanup: https://patchwork.kernel.org/patch/8513951/
Patch prompting all this: https://patchwork.kernel.org/patch/8513921/

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
