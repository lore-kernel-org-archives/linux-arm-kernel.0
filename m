From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Mon, 18 May 2015 10:17:45 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <20150518092750.449d6c8c@bbrezillon>
References: <55559D55.6020703@aksignal.cz>	<20150515172516.005e3a21@bbrezillon>	<5559865F.9010502@aksignal.cz>
 <20150518092750.449d6c8c@bbrezillon>
Message-ID: <5559A029.9060007@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18.5.2015 09:27, Boris Brezillon wrote:
>
> Can you dump watchdog registers (using devmem) ?

/ # devmem 0xfffffe40
0x00000000
/ # devmem 0xfffffe44
0x1FFF2FFF
/ # devmem 0xfffffe48
0x00000000
