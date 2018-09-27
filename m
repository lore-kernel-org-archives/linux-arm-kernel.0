From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 27 Sep 2018 09:28:06 -0700
Subject: [PATCH v8 07/12] dt-bindings: mfd: Add a document for PECI client
 MFD
In-Reply-To: <20180927151524.GA16798@bogus>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-8-jae.hyun.yoo@linux.intel.com>
 <20180927151524.GA16798@bogus>
Message-ID: <68edf927-a39a-dc54-9766-507e4fa789a5@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/27/2018 8:15 AM, Rob Herring wrote:
> On Tue, 18 Sep 2018 14:51:19 -0700, Jae Hyun Yoo wrote:
>> This commit adds a dt-bindings document for PECI client MFD.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: James Feist <james.feist@linux.intel.com>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   .../bindings/mfd/intel-peci-client.txt        | 34 +++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks for the review, Rob!
