From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 4 Jun 2015 11:16:47 +0800
Subject: [PATCH v5 2/4] clk: zx: add clock support to zx296702
In-Reply-To: <20150603235101.GD490@codeaurora.org>
References: <1432867178-5913-1-git-send-email-jun.nie@linaro.org>
 <CABymUCN0H9zwrKaPKmA13kq=5+ky=02wJzLEbuKG6UhaP_EqOA@mail.gmail.com>
 <20150603235101.GD490@codeaurora.org>
Message-ID: <CABymUCPdQZnstBG9byyHDzh81Wu77Kkd_KzC+yO5GCcYh6UtzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-04 7:51 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 05/29, Jun Nie wrote:
>> 2015-05-29 10:39 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
>> > It adds a clock driver for zx296702 SoC to register the clock tree to
>> > Common Clock Framework.  All the clocks of bus topology and some the
>> > peripheral clocks are ready with this commit. Some missing leaf clocks
>> > for peripherals will be added later when needed.
>>
>> Hi Stephen,
>>
>> Could you help review updated patch? All your comments are adopted. Thanks!
>>
>
> Did you want this to go through the clk tree? Or did you want a
> tag to take it through arm-soc? Sorry it isn't clear to me.

If you agree, I want to these patches go to arm-soc side because all
other arch initial patches are in arm-soc repo.
>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
