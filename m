From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 13 Jun 2017 17:18:26 +0800
Subject: [PATCH V3 0/3] clk: introduce clk_bulk_get accessories
In-Reply-To: <20170602224034.GX20170@codeaurora.org>
References: <1495201746-31841-1-git-send-email-aisheng.dong@nxp.com>
 <20170602224034.GX20170@codeaurora.org>
Message-ID: <CAA+hA=ROWfUD3LCxj=POs4QPeqKF0MjKQMeC2WMbVbGiRwL9vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sat, Jun 3, 2017 at 6:40 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/19, Dong Aisheng wrote:
>> These helper function allows drivers to get several clk consumers in
>> one operation.  If any of the clk cannot be acquired then any clks
>> that were got will be put before returning to the caller.
>>
>
> I've merged the first two into a stable branch and merged to
> clk-next. The third one can go via cpufreq.
>

Thanks.
I will resend the third once the first two hit mainline.

Regards
Dong Aisheng

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
