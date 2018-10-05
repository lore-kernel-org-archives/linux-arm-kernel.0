From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Fri, 5 Oct 2018 13:43:55 -0700
Subject: [PATCH i2c-next v6 1/5] dt-bindings: i2c: Add 'timeout-ms' and
 '#retries' properties as common optional
In-Reply-To: <20181005203930.GA12987@bogus>
References: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
 <20181004204322.20665-2-jae.hyun.yoo@linux.intel.com>
 <20181005203930.GA12987@bogus>
Message-ID: <842d268d-9e38-3c81-1b66-a0527206092b@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 10/5/2018 1:39 PM, Rob Herring wrote:
> On Thu, Oct 04, 2018 at 01:43:18PM -0700, Jae Hyun Yoo wrote:
>> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
>> @@ -80,6 +80,12 @@ wants to support one of the below features, it should adapt the bindings below.
>>   	Names of map programmable addresses.
>>   	It can contain any map needing another address than default one.
>>   
>> +- timeout-ms
> 
> bus-timeout-ms in case we have some other timeout needed.
> 

Agreed. I'll change it like you suggested.

Thanks,
Jae
