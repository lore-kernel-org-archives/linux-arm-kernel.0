From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Jul 2015 13:26:17 -0700
Subject: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
In-Reply-To: <55A38973.3020802@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <20150526160557.GD16525@atomide.com> <20150526163216.GF16525@atomide.com>
 <20150526163931.GO26599@saruman.tx.rr.com> <55660D5B.8020607@ti.com>
 <20150527231536.GD30984@atomide.com> <556EF42A.9000207@ti.com>
 <20150603231136.6017.65683@quantum> <55A38973.3020802@ti.com>
Message-ID: <55A41EE9.5030808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 02:48 AM, Tero Kristo wrote:
> On 06/04/2015 02:11 AM, Michael Turquette wrote:
>>
>> Hi Tero,
>>
>> I'd like more time for any regressions this introduces to be fixed, so
>> lets push back to next merge window. The always-wrong-but-never-by-much
>> crystal ball[0] predicts June 14. This is less than two weeks away, so
>> the wait should be short.
>
> Hi Mike / Stephen,
>
> I am planning to send a pull-request out for this, but this set is 
> going to cause some minor merge conflicts with the recent header file 
> change patches from Stephen, and the determine rate prototype change 
> from Boris.
>
> I can alternatively just ignore these issues and send these patches on 
> top of rc2 and let you handle the conflicts within clk-tree, or 
> cherry-pick some stable commits for the same if you like.
>
> Which way do you prefer?

It doesn't sound too bad to resolve those conflicts so send the branch 
that you already made based on v4.1-rc2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
