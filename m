From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Nov 2009 00:55:31 +0100
Subject: IXP425: help on HSS channelized service
In-Reply-To: <200911270921.35517.schindele@nentec.de> (Juergen Schindele's
	message of "Fri, 27 Nov 2009 10:21:34 +0200")
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<200911261543.08448.schindele@nentec.de>
	<m3y6ltt6ru.fsf@intrepid.localdomain>
	<200911270921.35517.schindele@nentec.de>
Message-ID: <m3bpinplos.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Schindele <schindele@nentec.de> writes:

>> Perhaps you're using IXP46x/43x CPU and the new firmware (3.x)?
>> The driver works with fw 2.4 (and some older), i.e. the last firmware
>> which works with IXP42x and 46x/43x.
> Thanks for your info. I thing thats the problem about it. I am using 
> an 2.0 firmware from INTEL and that could be the problem.

If that's really 2.0 and not 3.0 then you can upgrade to 2.4 which is
compatible with the HSS driver.
-- 
Krzysztof Halasa
