From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 02 Jun 2015 10:28:32 +0530
Subject: [PATCH 00/12] i2c: pxa: Fixes, cleanup and support for pxa910
 family
In-Reply-To: <fb192019ec75e9aa10b04b79e87a6e79@the-dreams.de>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <fb192019ec75e9aa10b04b79e87a6e79@the-dreams.de>
Message-ID: <556D37F8.2030904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 01 June 2015 05:37 AM, Wolfram Sang wrote:
>> TODO:
>>   - Due to lack of client driver support as of now, could not
>>     able to do functionality testing from client. I am working
>>     on PMIC driver support which is over I2C, so will have good
>>     meaningful testing then.
>
> Okay, thanks for the info. So, unless this is done I'll consider these
> patches as RFC.


I already have PMIC client driver up and doing some testing with it.
So we should not have this issue for my next version.

Thanks,
Vaibhav
