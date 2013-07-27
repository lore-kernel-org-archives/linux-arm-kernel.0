From: padma.kvr@gmail.com (Padma Venkat)
Date: Sat, 27 Jul 2013 06:43:23 +0530
Subject: [PATCH V2 1/8] platform: Increase platform name size
In-Reply-To: <CAK9yfHxX7j8o3rQNzDM2eL6M66CJVcdGSz3XYR2-4i=5SmCinA@mail.gmail.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-2-git-send-email-padma.v@samsung.com>
 <CAK9yfHxX7j8o3rQNzDM2eL6M66CJVcdGSz3XYR2-4i=5SmCinA@mail.gmail.com>
Message-ID: <CAAgF-Bf2fkcZG27QmkhumpB27OkA+WR4vRb1rUumJpOaoDewcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On Fri, Jul 26, 2013 at 8:06 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Padma,
>
> On 26 July 2013 19:06, Padmavathi Venna <padma.v@samsung.com> wrote:
>> This patch increases the platform name size from 20 to 30.
>
> Instead of describing what the patch does (which is quite obvious from
> the code), it would be useful to describe why this change is required.

OK. I will post in my next version.

>
>
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>>  include/linux/mod_devicetable.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index b62d4af..f67b5d5 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -478,7 +478,7 @@ struct dmi_system_id {
>>  #define DMI_MATCH(a, b)        { .slot = a, .substr = b }
>>  #define DMI_EXACT_MATCH(a, b)  { .slot = a, .substr = b, .exact_match = 1 }
>>
>> -#define PLATFORM_NAME_SIZE     20
>> +#define PLATFORM_NAME_SIZE     30
>>  #define PLATFORM_MODULE_PREFIX "platform:"
>>
>>  struct platform_device_id {
>> --
>> 1.7.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> With warm regards,
> Sachin

Thanks
Padma
