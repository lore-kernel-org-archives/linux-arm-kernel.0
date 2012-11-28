From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 28 Nov 2012 21:36:49 +0530
Subject: [RFC 1/2] clk: use struct clk only for external API
In-Reply-To: <CAOh2x=kw11+fGK6G_fKm2CA3TNGnG_mFq1eHeNxQ-B97-Wd_NA@mail.gmail.com>
References: <1354103571-27394-1-git-send-email-rabin.vincent@stericsson.com>
 <CAOh2x=kw11+fGK6G_fKm2CA3TNGnG_mFq1eHeNxQ-B97-Wd_NA@mail.gmail.com>
Message-ID: <CAOh2x=mTzMVykRymid_TKG8Y87GpuD9V1KZ0YyzmfY4GHtqydg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 9:31 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
> On Wed, Nov 28, 2012 at 5:22 PM, Rabin Vincent
> Isn't something wrong here? For common clk case shouldn't
> this be:
>
>> +#define clk_to_clk_core(clk)  (&clk->clk)
>> +#define clk_core_to_clk(core) (container_of(clk, ...))  //not getting into the exact format here
>
> Sorry, if i am missing basics.

Ok. I saw these getting updated in 2/2. But it means this individual patch
is broken and this is not allowed i believe.

--
viresh
