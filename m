From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 24 Oct 2018 09:39:51 -0700
Subject: [PATCH v8 07/12] dt-bindings: mfd: Add a document for PECI client
 MFD
In-Reply-To: <20181024072540.GA4939@dell>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-8-jae.hyun.yoo@linux.intel.com>
 <20181024072540.GA4939@dell>
Message-ID: <8c322777-7c35-1c2a-730f-f8de86522b96@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 10/24/2018 12:25 AM, Lee Jones wrote:
> On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:
> 
>> +Required properties:
>> +- compatible : Should be "intel,peci-client".
>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients starts from 0x30 based on PECI specification.
> 
> Nit: "start"
> 
> Would be better worded:
> 
> "According to the PECI specification client addresses start from 0x30."
> 

Yes, that would be better. Will fix it like you suggested.

Thanks for the review!

Jae
