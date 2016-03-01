From: Manish.Jaggi@caviumnetworks.com (Jaggi, Manish)
Date: Tue, 1 Mar 2016 12:03:36 +0000
Subject: for-next/pgtable branch: OOM error with 16K page size
In-Reply-To: <56D57B9D.7020604@arm.com>
References: <BY1PR0701MB159476A9E0E9B5DD9F17EC4BE1BA0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <BY1PR0701MB159496D44DB36F8C3699D3A5E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>,
 <56D57B9D.7020604@arm.com>
Message-ID: <BY1PR0701MB1594A21349ED87C30F900102E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>From: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
>>Sent: Tuesday, March 1, 2016 4:53 PM
>>To: Jaggi, Manish
>>Cc: linux-arm-kernel at lists.infradead.org; mark.rutland at arm.com
>>Subject: Re: for-next/pgtable branch: OOM error with 16K page size
>>
>>On 01/03/16 10:48, Jaggi, Manish wrote:
>>>
>>>>> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> on behalf of Jaggi, Manish <Manish.Jaggi@caviumnetworks.com>
>>>>> Sent: Monday, February 29, 2016 5:56 PM
>>>>> To: linux-arm-kernel at lists.infradead.org
>>>>> Subject: for-next/pgtable branch: OOM error with 16K page size
>>>>>
>>>>> Hi All,
>>>>>
>>>>> I am trying to use the for-next/pgtable branch with the top commit,
>>>
>>> The same issue is observed with for-next/core branch
>>>
>>
>>>>> Observations:
>>>>> a) During linux boot I see some oom messages
>>>>> http://pastebin.com/8jSMFhqf
>>>>>
>>>>> b) cat /proc/meminfo
>>>>>
>>>>> MemTotal:         66613760 kB
>>>>> MemFree:          307328 kB
>>>>> MemAvailable:      22416 kB
>>>>>
>>
>>
>>Could you please provide the complete o/p of the following
>>with 16K ?
>>
>>1) /proc/meminfo
>>2) /proc/buddyinfo
>>3) /proc/slabinfo

http://pastebin.com/Eszwp1cS

>>Thanks
>>Suzuki
