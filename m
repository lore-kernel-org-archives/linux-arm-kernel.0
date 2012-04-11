From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Apr 2012 13:37:50 +0200
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
In-Reply-To: <CAFumwP38ghv91gwZ55pQeDDD67_t+61pLqBkvX8wzZk5R-3z5w@mail.gmail.com>
References: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
 <20120408180906.GA13348@samfundet.no>
 <CAF8ieYVvWJDEkVheGrCuQ+4Ucx_WV-M3qXia1-Y97vqCmeeETQ@mail.gmail.com>
 <CAFumwP38ghv91gwZ55pQeDDD67_t+61pLqBkvX8wzZk5R-3z5w@mail.gmail.com>
Message-ID: <4F856D0E.5040802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2012 11:55 PM, Andrew Victor :
> hi,
> 
>> Yeah, as far as I know, nobody ever used this functionality on AVR32.
>> In fact, I can't even think of a reason to use it.
>>
>> But I seem to recall submitting a patch to remove this functionality a
>> long time ago, and it was struck down. I don't remember the reason,
>> but there's a chance it might still be valid.
> 
> Some of the SAN People / Multenet AT91RM9200 boards needed it....
> We needed to use GPIO pins for some of the modem-control signals -
> couldn't use the standard pins since the alternate pin function was
> being used.
> 
> Regards,
>  Andrew Victor

Hi Andrew,

Well if it is of some interest on your side, I am in favor of keeping
this feature. It is not a so big amount of code and seems quite easy to
maintain...

Thanks a lot to all for your feedback anyway.

Cheers,
-- 
Nicolas Ferre
