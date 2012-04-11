From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 11 Apr 2012 11:10:32 +0530
Subject: [PATCHv6 19/19] ARM: OMAP4: hwmod data: I2C: add flag for context
 restore
In-Reply-To: <alpine.DEB.2.00.1204101212530.20894@utopia.booyaka.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
 <1334055397-899-20-git-send-email-shubhrajyoti@ti.com>
 <alpine.DEB.2.00.1204101212530.20894@utopia.booyaka.com>
Message-ID: <4F851950.6060503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012 11:43 PM, Paul Walmsley wrote:
> On Tue, 10 Apr 2012, Shubhrajyoti D wrote:
>
>> Restore of context is not done for OMAP4. This patch
>> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
>> hwmod data which activates the restore for OMAP4.
>> Currently the OMAP4 does not hit device off still the
>> driver may have support for it.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Paul Wamsley <paul@pwsan.com>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Thanks, queued for 3.5.  You can drop this from your series; it will 
> likely cause merge conflicts if you don't.
Thanks Paul.
Will drop this patch and resend.
> - Paul
