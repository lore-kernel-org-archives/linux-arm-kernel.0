From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 25 Apr 2016 10:18:07 +0100
Subject: [GIT PULL] ARM: vexpress: Updates for v4.7
In-Reply-To: <7123166.4dBrA6hMxj@wuerfel>
References: <57112A05.3070709@arm.com> <7123166.4dBrA6hMxj@wuerfel>
Message-ID: <571DE0CF.1050507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 24/04/16 22:35, Arnd Bergmann wrote:
> On Friday 15 April 2016 18:51:01 Sudeep Holla wrote:
>
>> This time addition of support for Cortex-M based MPS2 system is
>> the main highlight. I could not split the patches into platform,
>> driver and DT because it's newly added and have Kconfig/Makefile
>> dependency.
>
> I don't get it. Why is there a dependency between the three things?
>

Sorry, I was just thinking from testing perspective earlier

> Usually nothing breaks by adding any of those things, so the only
> dependency is that you need them all in order to make the platform
> work, but that is not enough reason to put them into a common branch.
>

OK, I will check again. I agree nothing should break.

> Please respin this. When you do, it probably makes sense to
> separate the changes for vexpress from the new MPS2 platform
> into distinct branches.
>

OK

-- 
Regards,
Sudeep
