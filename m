From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 20 Apr 2012 13:01:34 -0700
Subject: [PATCH 13/13] clk: basic: improve parent_names & return errors
In-Reply-To: <CAAQ0ZWQ_haRN-WHNzTMcjFvryRqjM58QoseC8WejBiqcDfSuPA@mail.gmail.com>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-14-git-send-email-mturquette@linaro.org>
 <20120412064920.GH2445@S2101-09.ap.freescale.net>
 <CAJOA=zMPQK-W_nbRztXCNdLHoTJU73ZnrxAS8VvvmzgdaVS2mQ@mail.gmail.com>
 <CAAQ0ZWRg2jwNZ7Bx5j5NtCVveT_085VmFtPMhWW62-aO+kFfnw@mail.gmail.com>
 <CAJOA=zPnQhq_3O00F4dfUbnywW-Riov7N76F3wraE67yy2MMuA@mail.gmail.com>
 <CAAQ0ZWQ_haRN-WHNzTMcjFvryRqjM58QoseC8WejBiqcDfSuPA@mail.gmail.com>
Message-ID: <4F91C09E.8070308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2012 12:17 AM, Shawn Guo wrote:
> On 17 April 2012 11:50, Turquette, Mike<mturquette@ti.com>  wrote:
>> That is a good question.  I think it is worth waiting on Saravana's
>> patch which exposes non-private members of struct clk via struct
>> clk_hw.  This will have an effect on both platform clock data and
>> code.
>
> Saravana,
>
> (*nudge*) (*nudge*) goes to you now :)
>
> Regards,
> Shawn

Sorry :) Will do soon.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
