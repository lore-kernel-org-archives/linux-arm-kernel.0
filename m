From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 25 Apr 2017 10:36:33 +0530
Subject: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
In-Reply-To: <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7>
 <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7>
 <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
 <20170424114343.GS26900@vireshk-i7>
 <CAOMZO5AkTKjU5kw0gszLVdVOc_Sb_sWhr65heE==kyw=5rcN-g@mail.gmail.com>
Message-ID: <20170425050633.GV26900@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-04-17, 08:51, Fabio Estevam wrote:
> On Mon, Apr 24, 2017 at 8:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > 110 ms is your sampling rate right now. Looks too high.
> >
> > Try doing this:
> >
> > echo 10000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
> >
> > and retry your tests.
> 
> Tried 10ms and also 1ms, but touchscreen also failed in both cases.

Honestly, I don't have a clue on how can we fix it for you now :)

@Rafael: Any idea apart from running at max all the time?

what touchscreen driver are you using btw? Just curious to see if there is any
bug in there. Handling touchscreen events shouldn't require us to run at max
freq.

@shawn: Saw something similar ever ?

-- 
viresh
