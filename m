From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 May 2017 12:38:26 +0530
Subject: [PATCH 5/6] dt-bindings: cpufreq: move Mediatek cpufreq
 dt-bindings document to proper place
In-Reply-To: <1494224387.9662.10.camel@mtkswgap22>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-6-git-send-email-sean.wang@mediatek.com>
 <20170508041827.GC17010@vireshk-i7>
 <1494224387.9662.10.camel@mtkswgap22>
Message-ID: <20170508070826.GF17010@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-05-17, 14:19, Sean Wang wrote:
> Okay, I will do it with you provided command again. 
> 
> What I did for the patch is just "git mv
> Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt"
> and no any changing data in the content.

I was quite sure that you have done exactly that, but then we are
supposed to review and make sure you haven't done any mistakes.

That's where those options would make our life easier. Look at the
patch created by that command and you wouldn't see any diff at all.

-- 
viresh
