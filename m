From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 26 Oct 2018 15:53:24 -0500
Subject: [PATCH] arm64: dts: stratix10: Correct System Manager register
 size
In-Reply-To: <ecd3e018-758a-3fd6-3524-379f84b67030@linux.intel.com>
References: <1537889512-586-1-git-send-email-thor.thayer@linux.intel.com>
 <ecd3e018-758a-3fd6-3524-379f84b67030@linux.intel.com>
Message-ID: <431d5e90-6227-35f6-bf8a-cbd59804e63e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/26/2018 03:15 PM, Thor Thayer wrote:
> Gentle ping...
> 
> On 9/25/18 10:31 AM, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Correct the register size of the System Manager node.
>>
>> Cc: stable at vger.kernel.org
>> Fixes: 78cd6a9d8e154 ("arm64: dts: Add base stratix 10 dtsi")
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---

This is already in arm-soc/next/dt and should land in v4.20-rc1.

Dinh
