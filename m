From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 3 Jan 2012 15:15:05 +0100
Subject: [PATCH 1/3] of/base: Take NULL string into account for property
 with multiple strings
In-Reply-To: <4EEF4401.1060303@gmail.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
 <1323095036-3739-2-git-send-email-b-cousson@ti.com>
 <4EEF4401.1060303@gmail.com>
Message-ID: <4F030D69.5010709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 12/19/2011 3:02 PM, Rob Herring wrote:
> On 12/05/2011 08:23 AM, Benoit Cousson wrote:
>> The current implementation just ignore any NULL string inserted in a
>> multiple strings property.
>> In some cases we can have a property with a fix number of strings but
>> not necessarily used, like for example in a list of valid pinmux modes.
>>
>>   prop = "uart_rx", "uart_tx", "", "", "safe_mode";
>>
>> Do no skip NULL string and take them into account in
>> of_property_read_string_index and of_property_count_strings.
>>
>> Reported-by: Tony Lindgren<tony@atomide.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>
> Applied. The others need Grant's agreement.

New year gentle ping.

Thanks,
Benoit
