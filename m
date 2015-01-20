From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 20 Jan 2015 13:47:41 +0900
Subject: [PATCHv8 2/9] devfreq: event: Add resource-managed function for
 devfreq-event device
In-Reply-To: <900879710.1308121421729191415.JavaMail.weblogic@epmlwas04a>
References: <900879710.1308121421729191415.JavaMail.weblogic@epmlwas04a>
Message-ID: <54BDDDED.7050009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2015 01:46 PM, MyungJoo Ham wrote:
>>   
>>  This patch add the resource-managed function for devfreq-event device as
>> following functions. The devm_devfreq_event_add_edev() manages automatically
>> the memory of devfreq-event device using resource management.
>> - devm_devfreq_event_add_edev()
>> - devm_devfreq_event_remove_edev()
>>
>> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.comA
> 
> Reviewed-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> You may merge this patch with 1/9 as well.
> I don't think this is a major change the requires a seperated patch.

OK. I'll merge it. on patch1.

Best Regards,
Chanwoo Choi
