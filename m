From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Jan 2013 10:01:48 +0100
Subject: [PATCH] ARM: at91: at91sam9x5.dtsi:usart3 TXD
In-Reply-To: <5108DE57.4090905@interlog.com>
References: <51083A70.1070809@interlog.com> <5108DE57.4090905@interlog.com>
Message-ID: <5108E17C.4080006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 09:48 AM, Douglas Gilbert :
> On 13-01-29 10:09 PM, Douglas Gilbert wrote:
>> Comment for usart3 TXD (TXD3) is correct, dt code is wrong.
>>
>> The patch is against lk 3.8.0-rc5 .
> 
> Actually this patch also depends on a patch by Robert Nelson
> titled: "[PATCH] ARM: at91: at91sam9x5: fix usart3 pinctrl name"
> posted on Monday 28 January, 2013. Two separate bugs in
> 3 lines of code, not bad going :-)

Okay, I try to queue both of them for 3.8-fixes...

Thanks, bye,
-- 
Nicolas Ferre
