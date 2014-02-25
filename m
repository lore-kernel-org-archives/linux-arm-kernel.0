From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 25 Feb 2014 14:25:48 -0600
Subject: [GIT PULL] qcom driver changes for v3.15
In-Reply-To: <201402251814.43712.arnd@arndb.de>
References: <alpine.DEB.2.00.1402250926210.17163@galak-ubuntu.qualcomm.com>
 <201402251814.43712.arnd@arndb.de>
Message-ID: <A3153995-5372-45F4-B7AA-D39911ED405B@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 25, 2014, at 11:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 25 February 2014, Kumar Gala wrote:
>> The following changes since commit cf1e8f0cd665e2a9966d2bee4e11ecc0938ff166:
>> 
>>   ARM: qcom: Rename various msm prefixed functions to qcom (2014-02-06 16:20:41 -0600)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-drivers-for-3.15
>> 
>> for you to fetch changes up to add798a40aec3a768165055477ba8bfee21e06fc:
>> 
>>   gpio: msm: switch Kconfig to ARCH_QCOM depends (2014-02-25 09:22:10 -0600)
>> 
> 
> Applied to the next/drivers branch now, and added a merge description
> that I adapted from your patch changelogs:
> 
>    Merge "qcom driver changes for v3.15" from Kumar Gala:
> 
>    We've split Qualcomm MSM support into legacy and multiplatform.  These
>    drivers are only relevant on the multiplatform supported SoCs so switch the
>    Kconfig depends to ARCH_QCOM.
> 
> It would be helpful if you can in the future always add a description
> yourself when creating the tag.
> 
> 	Arnd

Oops, I think when I updated the tag before sending I lost the message in the tag

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
