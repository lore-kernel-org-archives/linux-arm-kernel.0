From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 28 Apr 2017 21:07:39 -0700
Subject: [PATCH 1/2] dt-bindings: arm-ccn: Add bindings info for CCN-502
 compatible string
In-Reply-To: <20170214174833.GK23718@leverpostej>
References: <1486759368-24067-1-git-send-email-velibor.markovski@broadcom.com>
 <1486759368-24067-2-git-send-email-velibor.markovski@broadcom.com>
 <20170214174833.GK23718@leverpostej>
Message-ID: <1d697f53-8712-0378-b2ba-91537da5b56c@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark/Pawel,

I think this patch series has been missed.

On 17-02-14 09:48 AM, Mark Rutland wrote:
> On Fri, Feb 10, 2017 at 12:42:47PM -0800, Velibor Markovski wrote:
>> Add CCN-502 to the list of supported devices by ARM CCN PMU driver.
>>
>> Signed-off-by: Velibor Markovski <velibor.markovski@broadcom.com>
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
>
> I assume Pawel will take this along with the driver patch.
Could you please pick up this patch series?

>
> Thanks,
> Mark.
>
>> ---
>>  Documentation/devicetree/bindings/arm/ccn.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ccn.txt b/Documentation/devicetree/bindings/arm/ccn.txt
>> index b100d38..2980145 100644
>> --- a/Documentation/devicetree/bindings/arm/ccn.txt
>> +++ b/Documentation/devicetree/bindings/arm/ccn.txt
>> @@ -3,6 +3,7 @@
>>  Required properties:
>>
>>  - compatible: (standard compatible string) should be one of:
>> +	"arm,ccn-502"
>>  	"arm,ccn-504"
>>  	"arm,ccn-508"
>>
>> --
>> 1.9.1
>>

Thanks,
  Scott
