From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 17 Apr 2016 11:24:04 +0100
Subject: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
In-Reply-To: <5710BE85.10403@denx.de>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
 <201604150848.44242.jbe@pengutronix.de> <5710BE85.10403@denx.de>
Message-ID: <57136444.2010002@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 11:12, Marek Vasut wrote:
> On 04/15/2016 08:48 AM, Juergen Borleis wrote:
>> Hi Stefan,
>>
>> On Thursday 14 April 2016 17:48:27 Stefan Wahren wrote:
>>> This patch moves the STMP reset out of ADC init function
>>> in order to make it never fail. This is also necessary
>>> for PM ops.
>>
>> What do you mean with "make it never fail"?
> 
> He wants to make the function invoke only functions which don't return
> error value. Not a great wording, but the patch makes it clear.
I've reworded to make this a little clearer and applied it to the togreg branch
of iio.git initially pushed out as testing for the autobuilders
to play with it (also giving time for any more comments on it to come through)

Jonathan
> 
>>> [...]
>>
>> jb
>>
> 
> 
