From: stratosk@semaphore.gr (Stratos Karafotis)
Date: Fri, 25 Apr 2014 18:11:20 +0300
Subject: [PATCH v4 2/8] cpufreq: Use cpufreq_for_each_* macros for
 frequency table iteration
In-Reply-To: <CA+V-a8swMCPkf=rwbLOjiqAgpaQ7TZPutTQTh_sSFmbJvHz-1Q@mail.gmail.com>
References: <534DB1EB.1080401@semaphore.gr> <5355A327.3020308@semaphore.gr>
 <CA+V-a8swMCPkf=rwbLOjiqAgpaQ7TZPutTQTh_sSFmbJvHz-1Q@mail.gmail.com>
Message-ID: <535A7B18.9070505@semaphore.gr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

On 25/04/2014 03:31 ??, Prabhakar Lad wrote:
> Hi Stratos,
> 
> Thanks for the patch.
> 
> On Tue, Apr 22, 2014 at 4:30 AM, Stratos Karafotis
> <stratosk@semaphore.gr> wrote:
>> The cpufreq core now supports the cpufreq_for_each_entry and
>> cpufreq_for_each_valid_entry macros helpers for iteration over the
>> cpufreq_frequency_table, so use them.
>>
>> It should have no functional changes.
>>
> This patch produces following build warning,
> 
> drivers/cpufreq/freq_table.c: In function 'cpufreq_frequency_table_cpuinfo':
> drivers/cpufreq/freq_table.c:36:3: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 2 has type 'int'
> [-Wformat=]
>    pr_debug("table entry %lu: %u kHz\n", pos - table, freq);

Thanks for this finding.
I will fix it and resend the patch.


Stratos Karafotis
