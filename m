From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 13:27:37 +0530
Subject: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
In-Reply-To: <20150623071045.GC3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
 <20150623021622.GA16776@linux> <20150623071045.GC3245@x1>
Message-ID: <20150623075737.GH16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23-06-15, 08:10, Lee Jones wrote:
> > These virtual nodes aren't allowed in DT and you have added them
> > before the bindings patch :).
> 
> This isn't a virtual node, but you bring up a good point.

Hmm, wrong choice of words. Sorry.. 

So, its a node for a virtual device :). The device is CPU and it
already has a node for itself. And so such nodes were discouraged
earlier by DT maintainers.

-- 
viresh
