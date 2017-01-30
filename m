From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 30 Jan 2017 17:19:18 +0000
Subject: [PATCH v2 1/3] arm64: cacheinfo: add support for alternative
 format of CCSIDR_EL1
In-Reply-To: <568a27c1-f910-46e8-7283-2040e28df380@arm.com>
References: <1485793527-18028-1-git-send-email-sudeep.holla@arm.com>
 <ad552a58-4acd-f2ab-7d40-124b40c6c014@arm.com>
 <568a27c1-f910-46e8-7283-2040e28df380@arm.com>
Message-ID: <ca857fb8-15f9-4b03-3b5a-fbc16d5ff7d3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/17 16:57, Sudeep Holla wrote:
>> Could this be static ? I could not see it used anywhere else outside
>> this file.
>
> Used in arch/arm64/kernel/cpuinfo.c

Ah, you're right.

Suzuki
