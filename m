From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 17 Jul 2015 11:12:04 +0530
Subject: [PATCH 4/5] regulator: 88pm800: Add 88pm860 regulator support
In-Reply-To: <20150716213429.GE1602@sirena.org.uk>
References: <1437070618-21330-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437070618-21330-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150716213429.GE1602@sirena.org.uk>
Message-ID: <55A895AC.8070101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 17 July 2015 03:04 AM, Mark Brown wrote:
> On Thu, Jul 16, 2015 at 11:46:57PM +0530, Vaibhav Hiremath wrote:
>> 88PM860 falls under 88pm800 family of devices, with
>> additional feature enhancements, like,
>>    - 88pm860 had additional BUCK regulator (BUCK6 and BUCK1B)
>>    - Additional LDO (LDO20)
>>    - different voltage and current capability
>
> ...and reverted since this doesn't build as the kbuild test robot
> reported.  :(
>

How do you suggest to handle dependency between MFD patch and this
patch?

Can you merge this into regulator tree?

Link to MFD - https://lkml.org/lkml/2015/7/16/704

Thanks,
Vaibhav
