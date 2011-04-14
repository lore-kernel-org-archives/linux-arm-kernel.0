From: b32955@freescale.com (Huang Shijie)
Date: Thu, 14 Apr 2011 14:40:58 +0800
Subject: [PATCH v5 2/4] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <19878.38524.705271.384302@ipc1.ka-ro>
References: <1302675881-18862-1-git-send-email-b32955@freescale.com>	<1302675881-18862-3-git-send-email-b32955@freescale.com>	<19877.65411.687158.113390@ipc1.ka-ro>	<4DA659D0.9030504@freescale.com>
	<19878.38524.705271.384302@ipc1.ka-ro>
Message-ID: <4DA696FA.90804@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi:
> Hi,
>
> Huang Shijie writes:
>>>> +	this->swap_block_mark = true;
>>>> +	if (GPMI_IS_MX23(this))
>>>> +		this->swap_block_mark = false;
>>>>
>>> if ... else ...?
>> else is "true" by default.
>>
> I meant it would be clearer to do:
> 	if (GPMI_IS_MX23(this))
> 		this->swap_block_mark = false;
> 	else
> 		this->swap_block_mark = true;
>
:)

thanks.

Huang Shijie
> Lothar Wa?mann
