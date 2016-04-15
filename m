From: marex@denx.de (Marek Vasut)
Date: Fri, 15 Apr 2016 12:12:21 +0200
Subject: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
In-Reply-To: <201604150848.44242.jbe@pengutronix.de>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
 <201604150848.44242.jbe@pengutronix.de>
Message-ID: <5710BE85.10403@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2016 08:48 AM, Juergen Borleis wrote:
> Hi Stefan,
> 
> On Thursday 14 April 2016 17:48:27 Stefan Wahren wrote:
>> This patch moves the STMP reset out of ADC init function
>> in order to make it never fail. This is also necessary
>> for PM ops.
> 
> What do you mean with "make it never fail"?

He wants to make the function invoke only functions which don't return
error value. Not a great wording, but the patch makes it clear.

>> [...]
> 
> jb
> 


-- 
Best regards,
Marek Vasut
