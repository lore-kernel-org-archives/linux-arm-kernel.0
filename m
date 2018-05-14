From: bst@pengutronix.de (Bastian Stender)
Date: Mon, 14 May 2018 11:18:12 +0200
Subject: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
In-Reply-To: <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
 <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
 <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <1c485c97-f667-7cbd-a6a0-bc74d8aa0918@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2018 11:10 AM, Anson Huang wrote:
>> -----Original Message-----
>> From: Bastian Stender [mailto:bst at pengutronix.de]
>> Sent: Monday, May 14, 2018 4:37 PM
>> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
>> s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
>> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
>> rjw at rjwysocki.net; viresh.kumar at linaro.org; rui.zhang at intel.com;
>> edubezval at gmail.com
>> Cc: devicetree at vger.kernel.org; linux-pm at vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org;
>> linux-kernel at vger.kernel.org
>> Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
>>
>> Hi,
>>
>> On 05/14/2018 10:09 AM, Anson Huang wrote:
>>> This patch removes cpufreq cooling registration in thermal .probe
>>> function, cpufreq cooling should be done in cpufreq driver when it is
>>> ready.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>
>> It seems you are trying to achieve something similar to a patch I sent a couple
>> of month ago. Unfortunately I did not have the time to rework it yet:
>>
>>
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
>> work.kernel.org%2Fpatch%2F10059085%2F&data=02%7C01%7Canson.huang
>> %40nxp.com%7C179da3635cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6f
>> a92cd99c5c301635%7C0%7C0%7C636618838508978629&sdata=BcQ9tc%2BE
>> CZ%2Fk4AsZFxshgmvSsPg7eRN0ASzP8LO8yBI%3D&reserved=0
>>
>> Some of the comments might apply here too.
> 
> Ah, I did NOT notice this thread, so how to proceed, will you 
> continue to finish your patch? If yes, then you can just ignore/skip
> my patch, thanks.
Yes, I will revisit the patch in a couple of weeks. It would be nice to
get your feedback then.

Regards,
Bastian	

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
