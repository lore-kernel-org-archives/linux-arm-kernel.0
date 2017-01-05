From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 5 Jan 2017 13:17:51 -0800
Subject: [PATCH v2] soc: ti: Drop wait from wkup_m3_rproc_boot_thread
In-Reply-To: <482666d0-7915-ead2-c514-2651a4967a43@ti.com>
References: <1483486889-3662-1-git-send-email-spjoshi@codeaurora.org>
 <482666d0-7915-ead2-c514-2651a4967a43@ti.com>
Message-ID: <d98575a9-1863-88f0-d417-ae894db2dc55@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/5/2017 1:08 PM, Suman Anna wrote:
> On 01/03/2017 05:41 PM, Sarangdhar Joshi wrote:
>> The function wkup_m3_rproc_boot_thread waits for
>> asynchronous firmware loading to parse the resource table
>> before calling rproc_boot(). However, as the resource table
>> parsing has been moved to rproc_boot(), there's no need to
>> wait for the asynchronous firmware loading completion.
>> So, drop this.
>>
>> CC: Dave Gerlach <d-gerlach@ti.com>
>> CC: Suman Anna <s-anna@ti.com>
>> CC: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
>
> + Tony and Santosh, not sure who is picking up the wkup_m3 related patches.
>
I think Tony has queued patches for wakeup_m3 before.

Regards,
Snatosh
