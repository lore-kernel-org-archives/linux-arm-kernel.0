From: james.morse@arm.com (James Morse)
Date: Fri, 04 Dec 2015 11:00:48 +0000
Subject: [PATCH v7 1/3] arm64: Add irq_stack boiler plate, store struct
 task_info in sp_el0
In-Reply-To: <C4231496-71BE-4D48-9575-D375D141136D@gmail.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-2-git-send-email-james.morse@arm.com>
 <C4231496-71BE-4D48-9575-D375D141136D@gmail.com>
Message-ID: <56617260.1030606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/15 16:32, Jungseok Lee wrote:
> On Nov 17, 2015, at 3:22 AM, James Morse wrote:
>> [Added per_cpu definitions and initialisation for irq_stack]
> 
> How about moving all irq_stack items to [PATCH 2/3] or [PATCH 3/3]?

They ended up in patch 1 because this was all originally one patch, and
patch 1 already modified those files.

I have moved them into patch 2 for v8.


Thanks,

James
