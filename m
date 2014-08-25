From: info@lategoodbye.de (Stefan Wahren)
Date: Mon, 25 Aug 2014 12:30:25 +0200
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <20140825080123.GA12289@dragon>
References: <53F9B4BF.2050802@lategoodbye.de> <20140825080123.GA12289@dragon>
Message-ID: <53FB1041.5010208@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.08.2014 10:01, schrieb Shawn Guo:
> On Sun, Aug 24, 2014 at 11:47:43AM +0200, Stefan Wahren wrote:
>> Hi,
>>
>> could you please tell me, is i.MX28 supported by cpufreq-cpu0?
>>
>> Do we need only the necessary DT entries like operating points or is
>> it more?
>
> Clock might as simple as adding DT entries, but I'm not sure we have
> voltage scaling support for i.MX28 in kernel.
>
> Shawn
>

As far as i know, the old Freescale BSP (2.6.35) contains a cpufreq 
driver for mxs, which never goes to mainline. So i'm not sure what would 
be the best way: porting the old driver or using cpufreq-cpu0.

Stefan
