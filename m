From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 16 Jan 2015 13:42:27 +0100
Subject: [PATCH 4/4] clk: pxa: add missing pxa27x clocks for Irda and
 sa1100-rtc
In-Reply-To: <20150112235256.20842.68349@quantum> (Mike Turquette's message of
 "Mon, 12 Jan 2015 15:52:56 -0800")
References: <1419688528-760-1-git-send-email-robert.jarzmik@free.fr>
 <1419688528-760-5-git-send-email-robert.jarzmik@free.fr>
 <20150112235256.20842.68349@quantum>
Message-ID: <87sifax5fw.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette <mturquette@linaro.org> writes:

> Quoting Robert Jarzmik (2014-12-27 05:55:28)
>> Add 2 clocks which were erronously forgotten by the clock framework
>> port, namely :
>>  - sa1100-rtc
>>  - irda for pxa2xx-ir:UARTCLK
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Acked-by: Michael Turquette <mturquette@linaro.org>

Thanks for the review and the ack Michael, I'll push that in pxa/for-next.

Cheers.

--
Robert
