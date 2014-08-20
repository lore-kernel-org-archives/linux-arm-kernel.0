From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 20 Aug 2014 09:29:35 +0200
Subject: [PATCH] mmc: atmel-mci: add 0x600 IP version
In-Reply-To: <53F39F3A.1090704@atmel.com>
References: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
 <53F39F3A.1090704@atmel.com>
Message-ID: <CAPDyKFopHQzYuCjC09i0QYJ92FhXskN7TtQOkYEd5_o4JMJKSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2014 21:02, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 12/06/2014 02:47, Ludovic Desroches :
>> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Chris, Ufl,
>
> It seems that this tiny patch got forgotten: Should we re-send it?
>
> Thanks, bye,

Sorry for delay.

I have applied it for next now. Thanks!

Kind regards
Uffe

>
>> ---
>>  drivers/mmc/host/atmel-mci.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index 1b4b064..9c4c191 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -2306,6 +2306,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>>
>>       /* keep only major version number */
>>       switch (version & 0xf00) {
>> +     case 0x600:
>>       case 0x500:
>>               host->caps.has_odd_clk_div = 1;
>>       case 0x400:
>>
>
>
> --
> Nicolas Ferre
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
