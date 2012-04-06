From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 6 Apr 2012 16:02:37 +0530
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <4F7DA009.4010802@linux.intel.com>
References: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
 <4F7DA009.4010802@linux.intel.com>
Message-ID: <CAMQu2gzwe0F3qcaTqASEPUASdG1SjpUxrBrSp-RrYLgy3W24OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On Thu, Apr 5, 2012 at 7:07 PM, Arjan van de Ven <arjan@linux.intel.com> wrote:
> On 4/5/2012 2:53 AM, Peter De Schrijver wrote:
>> This patch doesn't update all cpuidle device registrations. I will do that
>
> question is if you want to do per cpu latencies, or if you want to have
> both types of C state in one big table, and have each of the tegra cpyu
> types pick half of them...
>
>
Indeed !! That should work.
I thought the C-states are always per CPU based and during the
cpuidle registration you can register C-state accordingly based on the
specific CPU types with different latencies if needed.

Am I missing something ?

Regards
Santosh
