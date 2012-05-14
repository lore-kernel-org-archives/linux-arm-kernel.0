From: ccross@android.com (Colin Cross)
Date: Sun, 13 May 2012 19:46:34 -0700
Subject: [PATCH] cpu_pm: fix some typos in comments
In-Reply-To: <CAG9bXvkm6KVRpca9-YBq9oRiUyFLeaD+gwysCjpMO4Xo69XBXQ@mail.gmail.com>
References: <CAG9bXvkn6bm1xXpBxqvOxxzSrPPRdvP7RzKrfhSVJebN54psHQ@mail.gmail.com>
 <CAG9bXvkm6KVRpca9-YBq9oRiUyFLeaD+gwysCjpMO4Xo69XBXQ@mail.gmail.com>
Message-ID: <CAMbhsRSe-SNd8iDResx=Yqja96OD69unCH_WpcmFEH08jzv3EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2012 at 7:43 PM, Raul Xiong <raulxiong@gmail.com> wrote:
> 2012/5/11 Raul Xiong <raulxiong@gmail.com>:
>> Fix some comment typos in function names
>>
>> Signed-off-by: Raul Xiong <raulxiong@gmail.com>
>> ---
>> ?kernel/cpu_pm.c | ? ?8 ++++----
>> ?1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
>> index 249152e..957b151 100644
>> --- a/kernel/cpu_pm.c
>> +++ b/kernel/cpu_pm.c
>> @@ -81,7 +81,7 @@ int cpu_pm_unregister_notifier(struct notifier_block *nb)
>> ?EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
>>
>> ?/**
>> - * cpm_pm_enter - CPU low power entry notifier
>> + * cpu_pm_enter - CPU low power entry notifier
>> ?*
>> ?* Notifies listeners that a single CPU is entering a low power state that may
>> ?* cause some blocks in the same power domain as the cpu to reset.
>> @@ -115,7 +115,7 @@ int cpu_pm_enter(void)
>> ?EXPORT_SYMBOL_GPL(cpu_pm_enter);
>>
>> ?/**
>> - * cpm_pm_exit - CPU low power exit notifier
>> + * cpu_pm_exit - CPU low power exit notifier
>> ?*
>> ?* Notifies listeners that a single CPU is exiting a low power state that may
>> ?* have caused some blocks in the same power domain as the cpu to reset.
>> @@ -139,7 +139,7 @@ int cpu_pm_exit(void)
>> ?EXPORT_SYMBOL_GPL(cpu_pm_exit);
>>
>> ?/**
>> - * cpm_cluster_pm_enter - CPU cluster low power entry notifier
>> + * cpu_cluster_pm_enter - CPU cluster low power entry notifier
>> ?*
>> ?* Notifies listeners that all cpus in a power domain are entering a low power
>> ?* state that may cause some blocks in the same power domain to reset.
>> @@ -174,7 +174,7 @@ int cpu_cluster_pm_enter(void)
>> ?EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
>>
>> ?/**
>> - * cpm_cluster_pm_exit - CPU cluster low power exit notifier
>> + * cpu_cluster_pm_exit - CPU cluster low power exit notifier
>> ?*
>> ?* Notifies listeners that all cpus in a power domain are exiting form a
>> ?* low power state that may have caused some blocks in the same power domain
>
>
> Hi Colin, all,
>
> Is there any problem to accept this patch?
>
>
> Raul
> Best Regards

Nicolas Pitre posted a similar patch in March that fixed these plus
one more typo, and got two acks.  That one should probably go in.
