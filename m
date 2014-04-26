From: stratosk@semaphore.gr (Stratos Karafotis)
Date: Sat, 26 Apr 2014 14:35:37 +0300
Subject: [PATCH v5 2/8] cpufreq: Use cpufreq_for_each_* macros for
 frequency table iteration
In-Reply-To: <CA+V-a8sg9sBi5mf9KoFWrCJjw6WN+tGrb=bgJwfV3VDZ2DGYig@mail.gmail.com>
References: <535AC26A.1000006@semaphore.gr>
 <CA+V-a8sg9sBi5mf9KoFWrCJjw6WN+tGrb=bgJwfV3VDZ2DGYig@mail.gmail.com>
Message-ID: <535B9A09.9060902@semaphore.gr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

On 26/04/2014 12:57 ??, Prabhakar Lad wrote:
> Hi Stratos,
> 
> Thanks for the patch,
> 
> On Sat, Apr 26, 2014 at 1:45 AM, Stratos Karafotis
> <stratosk@semaphore.gr> wrote:
>> The cpufreq core now supports the cpufreq_for_each_entry and
>> cpufreq_for_each_valid_entry macros helpers for iteration over the
>> cpufreq_frequency_table, so use them.
>>
>> It should have no functional changes.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> 
> For patches 1 & 2:  Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> and for patch 3: Acked-and-tested-by: Lad, Prabhakar
> <prabhakar.csengg@gmail.com>
> 
> Thanks,
> --Prabhakar lad
> 

Thank you very much!


Stratos Karafotis
