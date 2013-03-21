From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Mar 2013 09:26:45 -0500
Subject: [PATCH 01/11] OF: add empty of_device_is_available for !OF
In-Reply-To: <20130321141812.GG15279@e106331-lin.cambridge.arm.com>
References: <1363820051-24428-1-git-send-email-robherring2@gmail.com>
 <1363820051-24428-2-git-send-email-robherring2@gmail.com>
 <20130321141812.GG15279@e106331-lin.cambridge.arm.com>
Message-ID: <514B18A5.20001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 09:18 AM, Mark Rutland wrote:
> On Wed, Mar 20, 2013 at 10:54:01PM +0000, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Add an empty version of of_device_is_available.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  include/linux/of.h |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index a0f1292..6fe655b 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -379,6 +379,11 @@ static inline int of_device_is_compatible(const struct device_node *device,
>>  	return 0;
>>  }
>>  
>> +static inline int of_device_is_available(const struct device_node *device,)
> 
> I assume that comma shouldn't be there?                                     ^

Right. I've fixed that up in my git tree.

Rob
