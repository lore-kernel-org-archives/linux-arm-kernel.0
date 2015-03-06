From: wuyun.wu@huawei.com (Yun Wu (Abel))
Date: Fri, 6 Mar 2015 09:36:30 +0800
Subject: [PATCH v3 0/5] enhance configuring an ITS
In-Reply-To: <54F8481A.2090509@arm.com>
References: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
 <54F8481A.2090509@arm.com>
Message-ID: <54F9049E.6070209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 20:12, Marc Zyngier wrote:

> On 04/03/15 03:18, Yun Wu wrote:
>> This patch series makes some enhancement to ITS configuration in the
>> following aspects:
>>
>> o make allocation of the ITS tables more sensible
>> o replace magic numbers with sensible macros
>> o guarantees a safe quiescent status before initializing an ITS
>>
>> This patch series is based on Marc's branch[1], and tested on Hisilion
>> ARM64 board with GICv3 ITS hardware.
> 
> So this now looks pretty good (assuming you fix the couple of nits I
> mentioned).
> 
> As this relies on my branch, shall I take it and ask Jason to look at
> the branch as a whole?
> 

Yes, please.

Thanks,
	Abel
