From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 13 Apr 2012 15:27:32 -0700
Subject: [PATCH 02/13] clk: core: remove dead code paths
In-Reply-To: <4F8672CC.2040500@st.com>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-3-git-send-email-mturquette@linaro.org>
 <4F8672CC.2040500@st.com>
Message-ID: <CAJOA=zPfYTj=o1HKiBaL5J+aa4BsTFPFDYZ5FcBkNzRd7jTZXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:14 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 4/12/2012 6:32 AM, Mike Turquette wrote:
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 3ed36d3..4daacf5 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -194,7 +194,7 @@ static int __init clk_debug_init(void)
>> ?late_initcall(clk_debug_init);
>> ?#else
>> ?static inline int clk_debug_register(struct clk *clk) { return 0; }
>> -#endif /* CONFIG_COMMON_CLK_DEBUG */
>> +#endif
>
> Why is this updated? Isn't this considered good practice anymore?

See comments in this thread:
http://article.gmane.org/gmane.linux.kernel/1276102

Regards,
Mike
