From: stratosk@semaphore.gr (Stratos Karafotis)
Date: Tue, 15 Apr 2014 14:02:26 +0300
Subject: [PATCH 08/20] cpufreq: exynos5440: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <CAKohpokfsR3soykZbtH4-L=4TC6Oab=jyzUr=W-EfkRFfefRDQ@mail.gmail.com>
References: <534C4E7E.4090806@semaphore.gr>
 <CAKohpokfsR3soykZbtH4-L=4TC6Oab=jyzUr=W-EfkRFfefRDQ@mail.gmail.com>
Message-ID: <534D11C2.3080206@semaphore.gr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/2014 08:44 ??, Viresh Kumar wrote:
> On 15 April 2014 02:39, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> 
>> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> 
>>  static void exynos_enable_dvfs(unsigned int cur_frequency)
>>  {
>> -       unsigned int tmp, i, cpu;
>> +       unsigned int tmp, cpu;
>>         struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
>> +       struct cpufreq_frequency_table *pos;
> 
> Merge above two.
> 

Then the line will be 82 characters long.
Do you mind to keep it as is?


Stratos
