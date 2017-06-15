From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 15 Jun 2017 09:41:22 +0100
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <20170614223453.3357117a7f25ee68924a071c@arm.com>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
 <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
 <20170614062229.GA28496@leoy-ThinkPad-T440>
 <20170614223453.3357117a7f25ee68924a071c@arm.com>
Message-ID: <d9b1121b-6e04-dfe7-b75b-9fbc6129a907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/06/17 04:34, Kim Phillips wrote:
[...]

> 
> How does one tell whether writes to /dev/cpu_dma_latency are effective?
> 
Watch /sys/devices/system/cpu/cpu*/cpuidle/state*/{usage,time}, they
shouldn't tick based on the value set to cpu_dma_latency.

E.g. a value of 0 should stop entering all the idle states.

-- 
Regards,
Sudeep
