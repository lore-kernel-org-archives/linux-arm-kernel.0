From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 10 Dec 2013 23:28:01 +0800
Subject: questions of cpuidle
In-Reply-To: <52A72ADC.6000003@linux.intel.com>
References: <52A5C846.30308@linaro.org> <52A5E135.2020500@linux.vnet.ibm.com>
 <52A6AFD1.4010002@linaro.org> <52A72ADC.6000003@linux.intel.com>
Message-ID: <52A73301.3030905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 10:53 PM, Arjan van de Ven wrote:
> On 12/9/2013 10:08 PM, Alex Shi wrote:
>> And for monitor/mwait idle method, seems deep c-state cpu need to keep a
>> eye on memory bus. So seems the memory controller in cpu package is
>> impossible to get into sleep, right?
> not the memory bus
> the cache coherency logic ;-)
> 

Thanks a lot, Arjan!

But in Intel c7 state, l3 cache also flushed. Are there some other unit
monitor this?

-- 
Thanks
    Alex
