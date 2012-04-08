From: hskinnemoen@gmail.com (=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=)
Date: Sun, 8 Apr 2012 14:21:49 -0700
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
In-Reply-To: <20120408180906.GA13348@samfundet.no>
References: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
 <20120408180906.GA13348@samfundet.no>
Message-ID: <CAF8ieYVvWJDEkVheGrCuQ+4Ucx_WV-M3qXia1-Y97vqCmeeETQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 8, 2012 at 11:09 AM, Hans-Christian Egtvedt
<egtvedt@samfundet.no> wrote:
> Around Fri 06 Apr 2012 18:02:29 +0200 or thereabout, Joachim Eastwood wrote:
>> No AT91/AVR32 boards currently use at91_register_uart_fns so let's remove it.
>>
>> The only other mach in the kernel that has a *_register_uart_fns function
>> is SA1100 so the demand for this functionality is not great.
>
> I agree with your statement, and I've never used this functionality. I'll
> leave it to Nicolas to decide, AFAIK there are no AVR32 users of these
> functions, if there are, they've never submitted any board code upstream.

Yeah, as far as I know, nobody ever used this functionality on AVR32.
In fact, I can't even think of a reason to use it.

But I seem to recall submitting a patch to remove this functionality a
long time ago, and it was struck down. I don't remember the reason,
but there's a chance it might still be valid. The AT91 people should
know.

>> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Havard Skinnemoen <hskinnemoen@gmail.com>
