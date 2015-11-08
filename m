From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 8 Nov 2015 15:19:40 -0600
Subject: [PATCH] dma: fix returnvar.cocci warnings
In-Reply-To: <CAHp75VdRN14EWUaTPzO45Z_mBzeQ=9sqzP3mMsMSQ2nXNi5QKg@mail.gmail.com>
References: <alpine.DEB.2.10.1511080843100.2637@hadrien>
 <CAHp75VdRN14EWUaTPzO45Z_mBzeQ=9sqzP3mMsMSQ2nXNi5QKg@mail.gmail.com>
Message-ID: <563FBC6C.8040207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Shevchenko wrote:
>> >CC: Sinan Kaya<okaya@codeaurora.org>
>> >Signed-off-by: Fengguang Wu<fengguang.wu@intel.com>
> Who is the author?
> I suppose Fengguang is the reporter, right?
>

These are Julia Lawall's coccinelle scripts that automatically run on 
patches and report problems.  Just treat them like normal code reviews 
and incorporate the change in the next version of your patch.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
