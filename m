From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 06 Apr 2014 19:02:01 +0200
Subject: Kconfig ARM_ERRATA_753970?
In-Reply-To: <1396777049.30640.9.camel@x220>
References: <201404052101.19381.arnd@arndb.de>	
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
Message-ID: <53418889.2050002@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 06/04/2014 11:37, Paul Bolle wrote:
> On Sat, 2014-04-05 at 20:04 +0100, Arnd Bergmann wrote:
>> Gregory CLEMENT (1):
>>       ARM: mvebu: add initial support for the Armada 375 SOCs
>>
>> [...]
>>
>> Thomas Petazzoni (7):
>>       [...]
>>       ARM: mvebu: add initial support for the Armada 380/385 SOCs
> 
> These two commits added select statements for ARM_ERRATA_753970. But I
> couldn't find that Kconfig symbol. (I checked master of Linus' tree and
> current linux-next.) So it seems it was intended to select
> PL310_ERRATA_753970 here. Is that correct?

Yes it is correct. ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970
in kernel 3.2. I had just carry on the symbol name without noticed that
it have changed.

Do you want to send a fix, or do you prefer I take care of it?


Thanks,

Gregory


> 
> 
> Paul Bolle
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
