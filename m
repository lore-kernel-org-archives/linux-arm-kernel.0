From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Sat, 27 Jul 2013 18:59:56 +0530
Subject: [PATCH 1/3] clk: exynos5250: Add G2D gate clock
In-Reply-To: <20130726201800.7598.54329@quantum>
References: <1373013749-14530-1-git-send-email-sachin.kamat@linaro.org>
 <20130726201800.7598.54329@quantum>
Message-ID: <CAK9yfHw6KtVDAns-1JhNpiS0brTeUpfiHS-v3q7H2GLWkY-Adw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 July 2013 01:48, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Sachin Kamat (2013-07-05 01:42:27)
>> Adds gate clock for G2D IP for Exynos5250 SoC.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Mike Turquette <mturquette@linaro.org>
>
> I've taken patch #1 into clk-next.

Thanks Mike.

>
>> ---
>> This patch depends on the following patch:
>> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/20581
>
> I think I've gotten all three series you sent out, can you confirm?

I haven't seen any update in your tree [1] since quite some time. The
last commit I see in clk-next branch is 45e3ec3784 ("clk: tegra: fix
ifdef for tegra_periph_reset_assert inline"). I hope I am looking at
the right tree?

[1] git://git.linaro.org/people/mturquette/linux.git

-- 
With warm regards,
Sachin
