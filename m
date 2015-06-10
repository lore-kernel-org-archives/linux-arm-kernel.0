From: hyuk.myeong@lge.com (Hyuk Myeong)
Date: Wed, 10 Jun 2015 11:33:44 +0900
Subject: [PATCH] ARM: pgtable: Fix typo in the comment
In-Reply-To: <CAPvkgC1rWZNTHu6sVkPtOpbQaQ7EdvCUCUZu7twmn2wx=O6WOQ@mail.gmail.com>
References: <024f01d0a280$e561f460$b025dd20$@lge.com>
 <CAPvkgC1rWZNTHu6sVkPtOpbQaQ7EdvCUCUZu7twmn2wx=O6WOQ@mail.gmail.com>
Message-ID: <03af01d0a325$df7d9090$9e78b1b0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

On Tue, June 09, 2015 5:43 PM, Steve Capper <steve.capper@linaro.org> wrote:
> On 9 June 2015 at 07:52, Hyuk Myeong <hyuk.myeong@lge.com> wrote:
>> This patch fix a spelling typo in the comment in pgtable-2level.h.
>>
>
> Hi Hyuk,
>
>> Signed-off-by: Hyuk Myeong <hyuk.myeong@lge.com>
>> ---
>>  arch/arm/include/asm/pgtable-2level.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/pgtable-2level.h
>> b/arch/arm/include/asm/pgtable-2level.h
>> index bfd662e..49f91be 100644
>> --- a/arch/arm/include/asm/pgtable-2level.h
>> +++ b/arch/arm/include/asm/pgtable-2level.h
>> @@ -66,7 +66,7 @@
>>   *
>>   * However, when the "young" bit is cleared, we deny access to the page
>>   * by clearing the hardware PTE.  Currently Linux does not flush the TLB
>> - * for us in this case, which means the TLB will retain the transation
>> + * for us in this case, which means the TLB will retain the transaction
>
> Don't you mean "translation" rather than "transaction"?
> Cheers,


Thank you for the advice
I had been confused between the two because I assumed that "transaction" 
is not that bad in this context (as a set of the translation)

Like you said, if "translation" is better here than I will send a new patch
