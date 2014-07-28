From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 28 Jul 2014 11:56:42 -0700
Subject: [RESEND][PATCHv2 0/3] Fix for buggy u-boot memory banks
In-Reply-To: <CAL_JsqJv2_UHxHGFF=nFKQRiEwfFtH_7PhMPS=W=APyzc-yiTQ@mail.gmail.com>
References: <1405443816-29917-1-git-send-email-lauraa@codeaurora.org>
 <CAL_JsqJv2_UHxHGFF=nFKQRiEwfFtH_7PhMPS=W=APyzc-yiTQ@mail.gmail.com>
Message-ID: <53D69CEA.3060206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/26/2014 2:20 PM, Rob Herring wrote:
> On Tue, Jul 15, 2014 at 12:03 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> Hi,
>>
>> This is a resend of the series to fix the uboot bug exposed by the removal
>> of meminfo. I haven't gotten any acks though.
> 
> Is the bug with ATAGs that get converted to DT in the decompressor or
> u-boot puts the wrong info in DT directly?
> 

I believe it's u-boot putting the wrong info in DT directly. See
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266782.html

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
