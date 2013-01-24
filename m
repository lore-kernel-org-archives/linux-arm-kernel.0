From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Thu, 24 Jan 2013 10:42:22 +0100
Subject: Soc MC13783: Improve driver to handle LineIn
Message-ID: <510101FE.4060307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I would like to improve MC13783 driver to be able to control bypass of 
LineIn (RXINR/L) and feed Analog LineIn stream into ouput Mixer via 
ADDRXIN flag.
This first step one is for test purpose but I also need to select 
RXINR/L as capture source (I saw in RM that CODEC must be enabled and 
only RXINR flag must be selected as input) but nothing seems to be 
captured this is why I need bypass working to test input level, and so on.

I try to create a Mixer based on other driver but it doesn't work.
I try to finc information about widget macro SND_SOC_DAPM_* but it is 
hard to find something relevant.
* Which widgets can be link together ?
* Is there functional difference between VIRT and non-VIRT widget ?

I will post my code in some minutes after clean-up.

Thanks a lot.
Ga?tan Carlier.
