From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 15 Dec 2014 08:19:36 +0100
Subject: [PATCH RFC] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <201412142019.50047.marex@denx.de>
References: <1418570933-21585-1-git-send-email-stefan.wahren@i2se.com>
 <201412141712.12589.marex@denx.de>
 <1638147247.144508.1418577377536.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <201412142019.50047.marex@denx.de>
Message-ID: <548E8B88.8040100@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 14.12.2014 um 20:19 schrieb Marek Vasut:
> On Sunday, December 14, 2014 at 06:16:17 PM, Stefan Wahren wrote:
>>> [...]
>>>
>>> Also, it might be a good idea to zap the 0x3f mask and use HEX and DEC
>>> numbers consistently, but this is an idea for another patch.
>> Yes.
>>
>> Btw i hope this patch also fixes a SPI communication issue with our
>> hardware which forces us to bypass ref_io1 for ssp2.
>> But i will have access to that hardware tomorrow.
> Which issue would that be please ? 

i've posted the issue in the Freescale Community [1].

> What are the symptoms ?

Bits from the SPI slave are misinterpreted.

BR Stefan

[1] - https://community.freescale.com/thread/310434

>
> Best regards,
> Marek Vasut
