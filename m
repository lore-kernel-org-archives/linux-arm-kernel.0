From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 14 Dec 2009 21:02:42 -0600
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <ed62800912141543v2ab7ef63v4b6b2c33018b3296@mail.gmail.com>
References: <A6D19A13FE030A409EC4362C172E091F0E0495F6@eseldmw101.eemea.ericsson.se>	
	<20091204104930.GA28625@sirena.org.uk>	
	<A6D19A13FE030A409EC4362C172E091F0E071EB9@eseldmw101.eemea.ericsson.se>	
	<20091207114825.GA26965@rakim.wolfsonmicro.main>	
	<A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>	
	<20091207165628.GA24981@rakim.wolfsonmicro.main>	
	<20091213132413.GB1437@ucw.cz>	
	<20091214121247.GB22388@rakim.wolfsonmicro.main>	
	<20091214212257.GA9213@elf.ucw.cz>
	<ed62800912141543v2ab7ef63v4b6b2c33018b3296@mail.gmail.com>
Message-ID: <4B26FC52.6060307@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aras Vaichas wrote:
> Unfortunately the simple coulomb counting chips have the disadvantage
> that the CPU has to be running to accumulate the pulses. Of course,
> the pulses could wake the CPU from a suspend mode, but I'd rather not
> do that just to add "one" to a counter ...
>   

Could you have the coulomb-counting chip connected to a tiny
microcontroller, or even a dedicated hardware counter?  Then the main
CPU wouldn't need to wake as often, it could just ask the
microcontroller over I2C, or read/reset the hardware counter.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
