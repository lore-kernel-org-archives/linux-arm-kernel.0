From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 11 May 2015 16:05:33 +0200
Subject: [PATCH] net: ll_temac: Use one return statement instead of two
In-Reply-To: <alpine.DEB.2.10.1505071730090.2462@hadrien>
References: <b10b8e1e696a09152b9df535a8bd37e6500ac1c7.1431005352.git.michal.simek@xilinx.com>
 <alpine.DEB.2.10.1505071730090.2462@hadrien>
Message-ID: <5550B72D.2020004@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2015 05:30 PM, Julia Lawall wrote:
> On Thu, 7 May 2015, Michal Simek wrote:
> 
>> From: Michal Simek <monstr@monstr.eu>
>>
>> Use one return statement instead of two to simplify the code.
>> Both are returning the same value.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> The from should be the same as the signed off.  You need From if you want
> something different than what is naturally put by your mailer.  But that
> doesn't see to be the case.

ok. Fixed in v2.

Thanks,
Michal
