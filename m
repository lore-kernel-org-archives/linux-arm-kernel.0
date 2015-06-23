From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 14:30:16 +0530
Subject: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
In-Reply-To: <20150623083856.GH3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux> <20150623070651.GA3245@x1>
 <20150623075509.GF16776@linux> <20150623083856.GH3245@x1>
Message-ID: <20150623090016.GL16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-06-15, 09:38, Lee Jones wrote:
> Do you always write your documentation before implementing a
> feature?
> 
> Surely it goes;
>   Requirements Gathering
>   Plan and Prepare
>   Implement
>   Test
>   Document
>   Deliver
> 
> ;)

DT bindings aren't just simple documentation of how things are
working. I do things in the way you wrote earlier though :)

> That's not what it looks like to me:
> 
> git grep -C20 "compatible.*cpufreq" -- arch

Yeah, that's wrong. They got in much earlier and the bindings weren't
well thought through.

But they are discouraged today ..

-- 
viresh
