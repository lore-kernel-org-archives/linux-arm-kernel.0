From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 May 2017 12:36:46 +0530
Subject: [PATCH 6/6] dt-bindings: cpufreq: enhance Mediatek cpufreq
 dt-binding document
In-Reply-To: <1494226711.9662.22.camel@mtkswgap22>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-7-git-send-email-sean.wang@mediatek.com>
 <20170508042010.GD17010@vireshk-i7>
 <1494226711.9662.22.camel@mtkswgap22>
Message-ID: <20170508070646.GE17010@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-05-17, 14:58, Sean Wang wrote:
> > > +		opp at 598000000 {
> > 
> > s/opp@/opp-/
> 
> I have referred to other dt-binding as examples where they also use opp@
> as the prefix word.  e.g bindings/cpufreq/ti-cpufreq.txt did it.
> 
> Or I misunderstand something you pointed out here ?

Its on the way:

https://marc.info/?l=linux-kernel&m=149266711829469&w=2

-- 
viresh
