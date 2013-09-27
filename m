From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 27 Sep 2013 10:51:43 +0200
Subject: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility
 string
In-Reply-To: <52454342.80706@linaro.org>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
 <31f13d14-2af7-4285-8770-3cc7ef7e7b09@AM1EHSMHS008.ehs.local>
 <52454342.80706@linaro.org>
Message-ID: <c0351789-56de-47f7-bc03-6af126f8e45f@TX2EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 10:35 AM, Daniel Lezcano wrote:
> On 09/27/2013 10:19 AM, Michal Simek wrote:
>> On 09/27/2013 10:17 AM, Daniel Lezcano wrote:
>>> All zynq platforms have this compatibility string and there is no any other
>>> clone.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The patchset is only compile-tested (I don't have the hardware).
> 
> Michal or someone else, if you have the time can you give it a try ?
> 

Soren: Can you please retest it on hw?

Thanks,
Michal
