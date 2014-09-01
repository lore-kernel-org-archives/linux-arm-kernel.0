From: info@lategoodbye.de (Stefan Wahren)
Date: Mon, 01 Sep 2014 08:31:05 +0200
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>
References: <53F9B4BF.2050802@lategoodbye.de>	<20140825080123.GA12289@dragon>	<53FB1041.5010208@lategoodbye.de>	<CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>
 <CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>
Message-ID: <540412A9.4090806@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am 30.08.2014 19:07, schrieb Fabio Estevam:
> On Sat, Aug 30, 2014 at 2:05 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Stefan,
>>
>> On Mon, Aug 25, 2014 at 7:30 AM, Stefan Wahren <info@lategoodbye.de> wrote:
>>
>>> As far as i know, the old Freescale BSP (2.6.35) contains a cpufreq driver
>>> for mxs, which never goes to mainline. So i'm not sure what would be the
>>> best way: porting the old driver or using cpufreq-cpu0.
>>
>> First step would be to port the PMU driver into mainline.
>
> I mean this regulator driver:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/regulator/mxs-regulator.c?h=imx_2.6.35_maintain
>
> ,so that you can do the voltage scaling.
>

thanks. Okay, that leads to more questions:

How can i test a ported mxs-regulator driver, that it's really working? 
Is there any userspace interface?

Is there a good DT implementation of a similiar regulator driver, so i 
can orientate on?

What are the recommend mailing lists for this porting (linux-pm and 
linux-arm-kernel)?

BR Stefan
