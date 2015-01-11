From: baohua@kernel.org (Barry Song)
Date: Sun, 11 Jan 2015 23:58:28 +0800
Subject: [PATCH] clocksource: sirf: Remove unused variable
In-Reply-To: <548F09B6.6010202@linaro.org>
References: <1418659160-2115-1-git-send-email-thierry.reding@gmail.com>
 <548F09B6.6010202@linaro.org>
Message-ID: <CAGsJ_4zQqwNdu3z1hzuLd4gvxY8iA+9HfdoTE8_U2tDmRUBNYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-16 0:17 GMT+08:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 12/15/2014 04:59 PM, Thierry Reding wrote:
>>
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Commit ef89af1f4380 ("clocksource: sirf: Remove hard-coded clock rate")
>> removes all uses of the timer_div variable. Since the variable is no
>> longer used it should be removed.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>
>
> Applied to my tree. Thanks!

Daniel,

i didn't find this commit in any tree in kernel.org. am i missing something?

so i manually rebased "clocksource: marco: rename marco to atlas7"
against this commit.

can you help to apply the attached patch to your tree? i guess pulling
by arm-soc will cause conflicts.


>
>   -- Daniel
>

-barry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-clocksource-marco-rename-marco-to-atlas7.patch
Type: text/x-patch
Size: 20190 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150111/d2680e92/attachment-0001.bin>
