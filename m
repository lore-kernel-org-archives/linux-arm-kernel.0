From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 03 Jun 2013 09:48:07 +0530
Subject: [PATCH 3/3] ARM: S5P64X0: Remove duplicate uncompress code
In-Reply-To: <51A9B3BC.9000405@gmail.com>
References: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
 <1370000944-19786-4-git-send-email-tushar.behera@linaro.org>
 <51A9B3BC.9000405@gmail.com>
Message-ID: <51AC18FF.9010108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2013 02:11 PM, Sylwester Nawrocki wrote:
> Hi,
> 
> On 05/31/2013 01:49 PM, Tushar Behera wrote:
>> The uncompress code in S5P64X0 is almost same as the uncompress code
>> defined in plat-samsung. Better to reuse that code.
>>
>> Signed-off-by: Tushar Behera<tushar.behera@linaro.org>
>> ---
>>   arch/arm/mach-s5p64x0/include/mach/uncompress.h |  163
>> ++---------------------
>>   1 file changed, 8 insertions(+), 155 deletions(-)
> 
> Not sure if you are aware of it, Tomasz has already posted a patch that
> removes this duplicated code: https://patchwork.kernel.org/patch/2589331
> I think that patch is not yet merged though.
> 
> Regards,
> Sylwester

Tomasz,

I had somehow missed that mail.

The patch that I have additionally makes calculation of uart_base
conditional on DEBUG_LL in line with the rest of the patches.

Would you mind re-spining your patch with those changes?

Alternately, I can take your patch and do above modifications in them.

Let me know your opinion on this.

-- 
Tushar Behera
