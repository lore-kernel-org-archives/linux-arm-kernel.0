From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 03 Jun 2013 17:25:56 +0530
Subject: [PATCH 3/3] ARM: S5P64X0: Remove duplicate uncompress code
In-Reply-To: <13570629.4jzYey0dyq@amdc1227>
References: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
 <51A9B3BC.9000405@gmail.com> <51AC18FF.9010108@linaro.org>
 <13570629.4jzYey0dyq@amdc1227>
Message-ID: <51AC844C.1050500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> Tomasz,
>>
>> I had somehow missed that mail.
>>
>> The patch that I have additionally makes calculation of uart_base
>> conditional on DEBUG_LL in line with the rest of the patches.
>>
>> Would you mind re-spining your patch with those changes?
>>
>> Alternately, I can take your patch and do above modifications in them.
> 
> Unfortunately I'm unlikely to find time to do it myself in nearest future, so 
> feel free to do it. Thanks.
> 
> Keep in mind, however, that this patch was a dependency of
> 
> [PATCH 0/6] Samsung watchdog support clean-up
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/18736/focus=18951
> 
> so I would like to keep this series applicable.
> 

Sure. I will ensure that there is minimal change to the original patch
that you submitted.

> Best regards,
> 


-- 
Tushar Behera
