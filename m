From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue,  4 Aug 2015 10:38:19 +0200 (CEST)
Subject: [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage for sun7i-a20
 to a level all boards can supply
In-Reply-To: <20150803091300.GY2564@lukather>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de><20150803091300.GY2564@lukather>
Message-ID: <20150804083819.2F3EE6C83EF9@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Maxime Ripard schrieb am 03.08.2015 11:13:
> On Sun, Aug 02, 2015 at 09:23:06PM +0200, Timo Sigurdsson wrote:
>> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20
>> boards
>> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
>> voltage for the lowest operating point to 1.0V so all boards can actually use
>> it.
> 
> This is not a property of a board, but is the actual limit documented
> by Allwinner for the A20. Some individual SoCs might have wider
> tolerances, but that's not a property of a board, it's really a
> property of a single SoC, and we cannot make any assumption on the
> board.

Thanks for the clarification. That was a misunderstanding on my side. I can 
update the commit message in a second version of the patch, but the actual
code change can be kept as is then, I guess.

> (and please make sure to run checkpatch before sending your patches)

Sorry about that. Will do when I post a second version of the patch.

Thanks,

Timo
