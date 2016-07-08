From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jul 2016 15:12:48 +0200
Subject: [PATCH 1/4] spi: s3c64xx: rename goto labels to meaningful names
In-Reply-To: <577FA677.7090708@samsung.com>
References: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
 <1467980304-14093-2-git-send-email-andi.shyti@samsung.com>
 <577FA677.7090708@samsung.com>
Message-ID: <577FA6D0.2070403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 03:11 PM, Krzysztof Kozlowski wrote:
> On 07/08/2016 02:18 PM, Andi Shyti wrote:
>> In goto labels of the style of
> 
> s/In/The/
> 
>>
>>   err4:
>>   err3:
>>   err2:
>>   err1:
>>
>> is complex to insert in between new errors without renaming all
> 
> s/is/are/ (or just rewrite it... "The style of such goto labels... is")
> 
>> the goto statments. Replace the errX naming style to meaningful
> 
> s/statments/satements/

Yeah, nice job (to me)... error in error correction. Of course
"statements"...

BR,
Krzysztof
