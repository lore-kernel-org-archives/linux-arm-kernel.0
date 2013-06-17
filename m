From: davidb@codeaurora.org (David Brown)
Date: Mon, 17 Jun 2013 11:07:28 -0700
Subject: [PATCH/RESEND 01/12] msm_serial: Convert to clk_prepare/unprepare
In-Reply-To: <20130617175510.GA15370@kroah.com>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <1371490999-15501-2-git-send-email-sboyd@codeaurora.org>
 <20130617175510.GA15370@kroah.com>
Message-ID: <20130617180728.GA21158@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:55:10AM -0700, Greg Kroah-Hartman wrote:
>On Mon, Jun 17, 2013 at 10:43:08AM -0700, Stephen Boyd wrote:
>> Add calls to clk_prepare and unprepare so that MSM can migrate to
>> the common clock framework.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>
>Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>Or do you want me to take the serial ones through my tree?  It's your
>choice, either is fine for me.

I can go ahead and pull them through the MSM tree.

Thanks,
David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
