From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Dec 2014 16:58:28 +0100
Subject: [PATCH RFC] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <201412171700.52323.marex@denx.de>
References: <1418570933-21585-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5CQjpYtrNTT65-ikJua4N_osYj4UVgm3EV+sEvVWF59cg@mail.gmail.com>
 <5491379F.3090607@i2se.com> <201412171700.52323.marex@denx.de>
Message-ID: <5492F9A4.3070805@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Am 17.12.2014 um 17:00 schrieb Marek Vasut:
> On Wednesday, December 17, 2014 at 08:58:23 AM, Stefan Wahren wrote:
>> Hi Fabio,
>>
>> Am 17.12.2014 um 03:44 schrieb Fabio Estevam:
>>> Hi Stefan,
>>>
>>> On Sun, Dec 14, 2014 at 3:16 PM, Stefan Wahren <stefan.wahren@i2se.com> 
> wrote:
>>>> Btw i hope this patch also fixes a SPI communication issue with our
>>>> hardware which forces us to bypass ref_io1 for ssp2.
>>> Does this patch fix the SPI issue?
>> unfortunately not. If the 3.19-rc1 has been released, i send the fixed
>> patch.
>>
>> I've the theory that's an initialization issue. I've never heard of SPI
>> problems from the U-Boot users and we are using imx-bootlets.
>>
>> I'll try to test it with U-Boot.
> Please keep me in the loop, I'd be interested in what you find. Thanks!
>
> Best regards,
> Marek Vasut

i tested it with U-Boot, but the issue still exists. If there is any
progress, i'll inform you.

Stefan
