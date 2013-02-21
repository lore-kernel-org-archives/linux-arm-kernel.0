From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 21 Feb 2013 18:29:24 +0530
Subject: [PATCH 6/9] ARM: OMAP4+: Remove out of placed smp_wmb() in
 secondary wakeup code
In-Reply-To: <51261945.4040508@cogentembedded.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-7-git-send-email-santosh.shilimkar@ti.com>
 <51261945.4040508@cogentembedded.com>
Message-ID: <51261A2C.6020707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 February 2013 06:25 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 20-02-2013 19:18, Santosh Shilimkar wrote:
>
>> The smp_wmb() here is out of placed
>
>     s/placed/place/
>
>> and redundant. So remove it. It is
>> a left over of the pain_release
>
>    Sure it's not 'pen_release'?
>
>> cleanup mostly.
>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
Yes... Will fix.

Regards,
Santosh
