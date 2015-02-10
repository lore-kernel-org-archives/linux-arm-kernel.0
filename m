From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 10 Feb 2015 14:55:51 +0100
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>	<CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>	<54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
Message-ID: <54DA0DE7.5050708@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am 10.02.2015 um 14:09 schrieb Fabio Estevam:
> Hi Stefan,
>
> On Tue, Feb 10, 2015 at 11:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>> sorry no. But i will try to get a mx28evk to reproduce the problem and
> Just a comment: mx28evk comes without SPI NOR flash from the factory.
> I have populated one in my mx28evk (slot U49).

i tought it would be easy because of this nice flash socket, but it's
for NAND :-(

Could you apply only the clk-imx28.c part of my patch and see what happens?

Stefan

>
>> narrow down which part of the patch causes this problem.
>>
>> Did you see any problem with the clock control register settings?
> I haven't inspected the clock control registers yet.
>
> Regards,
>
> Fabio Estevam
