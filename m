From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 20 Oct 2016 15:21:30 +0100
Subject: [PATCH v2] drivers: psci: PSCI checker module
In-Reply-To: <613e4387-0ed5-ad58-7b74-a31b648f81e7@arm.com>
References: <20160921143905.36197-1-kevin.brodsky@arm.com>
 <e57565e8-bec9-0460-32d5-fb9f868cc4f8@arm.com>
 <613e4387-0ed5-ad58-7b74-a31b648f81e7@arm.com>
Message-ID: <2e2dedf4-192f-8657-10b1-24b426af5f00@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/10/16 14:38, Kevin Brodsky wrote:

[...]

>
> Thanks for the heads-up! I'll rebase on 4.9-rc1 and see what needs to be
> done.
>

Just be aware that v4.9-rc1 doesn't have commit 9cfb38a7ba5a
("sched/fair: Fix sched domains NULL dereference in
select_idle_sibling()") which fixes the cpuhotplug issue you would
observe.

-- 
Regards,
Sudeep
