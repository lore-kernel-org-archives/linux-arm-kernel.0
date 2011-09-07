From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Wed, 7 Sep 2011 15:43:19 +0000
Subject: [GIT PULL] DaVinci fixes for v3.1-rc6
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593025743E832@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593025743E832@dbde02.ent.ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B701B8C9@DLEE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar

We ran into the build error when we started using linux-davinci tree for V7 architecture. So this fix for the following to be re-worked to include V7 as well.

>> Linus Walleij (1):
>>       ARM: davinci: fix cache flush build error
Murali Karicheri
Software Design Engineer
email: m-karicheri2 at ti.com
Phone: (301) 407 9583


>> -----Original Message-----
>> From: davinci-linux-open-source-bounces at linux.davincidsp.com
>> [mailto:davinci-linux-open-source-bounces at linux.davincidsp.com] On Behalf
>> Of Nori, Sekhar
>> Sent: Wednesday, September 07, 2011 8:13 AM
>> To: Arnd Bergmann
>> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
>> kernel at lists.infradead.org
>> Subject: [GIT PULL] DaVinci fixes for v3.1-rc6
>> 
>> Hi Arnd,
>> 
>> Can you please pull the following fixes for v3.1-rc6?
>> 
>> These are not regression fixes in the strict sense since
>> none of the bugs were actually introduced in v3.1 and have
>> been around for a while. But I hope we don't have to wait
>> till v3.2 for these.
>> 
>> Thanks,
>> Sekhar
>> 
>> The following changes since commit
>> ddf28352b80c86754a6424e3a61e8bdf9213b3c7:
>>   Linus Torvalds (1):
>>         Linux 3.1-rc5
>> 
>> are available in the git repository at:
>> 
>>   git://gitorious.org/linux-davinci/linux-davinci.git fixes
>> 
>> Linus Walleij (1):
>>       ARM: davinci: fix cache flush build error
>> 
>> Rajashekhara, Sudhakar (1):
>>       ARM: davinci: da850 EVM: read mac address from SPI flash
>> 
>> Sergei Shtylyov (1):
>>       ARM: davinci: correct MDSTAT_STATE_MASK
>> 
>>  arch/arm/mach-davinci/board-da850-evm.c  |   28
>> ++++++++++++++++++++++++++++
>>  arch/arm/mach-davinci/include/mach/psc.h |    2 +-
>>  arch/arm/mach-davinci/sleep.S            |    6 +++++-
>>  3 files changed, 34 insertions(+), 2 deletions(-)
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source at linux.davincidsp.com
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
