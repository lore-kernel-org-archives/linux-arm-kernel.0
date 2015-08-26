From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Wed, 26 Aug 2015 14:53:39 +0800
Subject: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
In-Reply-To: <20150826021659.GD8784@linux>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <CALx668VWg2xVxzy8P7f5QFWRzm+TDJXUghL-_rbvRLsLYjtnng@mail.gmail.com>
 <1617873.VRHfat3V76@vostro.rjw.lan>
 <CALx668UvkYhLoU8rxLG70RqTzsnaiV5-ybDYTKqb4MEJS8pmRw@mail.gmail.com>
 <20150826021659.GD8784@linux>
Message-ID: <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 10:16 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-08-15, 09:25, Pi-Cheng Chen wrote:
>> The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
>> introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
>> cause some conflicts if it goes through your tree. I am not sure how this
>> should be handled, but should it be merged through Mediatek SoC maintainer
>> tree?
>
> Just get that applied to MTK tree, it doesn't have any dependency on
> rest of the patches for build/boot. The only thing is that cpufreq
> wouldn't work and it will work as soon as Rafael's and MTK's trees are
> merged by Linus.

Thanks for your explanation.

@Rafael, Would you please apply [1,2] to your tree?

@Matthias, Would you please apply [3/3] of this series?

Thanks.

Best Regards,
Pi-Cheng

>
> --
> viresh
