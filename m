From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 19 May 2017 18:53:23 +0100
Subject: [PATCH v10 10/10] arm64: dts: juno: Add Coresight CPU debug nodes
In-Reply-To: <0e1cf263-f0a0-2e78-c636-4b5d8205b7f7@arm.com>
References: <1495167957-14923-1-git-send-email-leo.yan@linaro.org>
 <1495167957-14923-11-git-send-email-leo.yan@linaro.org>
 <0e1cf263-f0a0-2e78-c636-4b5d8205b7f7@arm.com>
Message-ID: <87991f3d-dcb6-7d57-781e-8b81ff24219d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/17 18:44, Sudeep Holla wrote:
> Hi Suzuki, Leo,
>
> On 19/05/17 05:25, Leo Yan wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Add Coresight CPU debug nodes for Juno r0, r1 & r2. The CPU
>> debug areas are mapped at the same address for all revisions,
>> like the ETM, even though the CPUs have changed from r1 to r2.
>>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Mathieu Poirier <mathieu.porier@linaro.org>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> ARM-SoC team expect DTS to be routed via platform tree.
> So I have queued this for v4.13[1]

Sudeep

Thanks for picking that up.

Suzuki
