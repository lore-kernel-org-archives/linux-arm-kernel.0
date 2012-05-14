From: jason@lakedaemon.net (Jason)
Date: Mon, 14 May 2012 17:40:53 -0400
Subject: [GIT PULL] ARM: orion/dove: v3.4 fixes
In-Reply-To: <201205142045.23156.arnd@arndb.de>
References: <20120514182722.GM16338@titan.lakedaemon.net>
 <201205142045.23156.arnd@arndb.de>
Message-ID: <1dc1757e-4ade-4c17-9155-84475468065b@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> wrote:

>On Monday 14 May 2012, Jason Cooper wrote:
>> The following changes since commit
>d48b97b403d23f6df0b990cee652bdf9a52337a3:
>> 
>>   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)
>> 
>> are available in the git repository at:
>>   git://git.infradead.org/users/jcooper/linux.git
>orion_fixes_for_v3.4
>> 
>> Alexander Clouter (5):
>>       crypto: mv_cesa requires on CRYPTO_HASH to build
>>       ARM: orion5x: ts78xx whitespace cleanups
>>       ARM: orion5x: ts78xx fix NAND resource off by one
>>       ARM: orion5x: remove PM dependency from ts78xx
>>       ARM: orion5x: ts78xx debugging changes
>> 
>> Andrew Lunn (3):
>>       Orion5x: Fix warning: struct pci_dev declared inside paramter
>list
>>       Orion5x: Fix Section mismatch warnings
>>       Dove: Fix Section mismatch warnings
>> 
>> Jason Cooper (1):
>>       Merge branch 'v3.4-rc6-cleanup-v2' of
>git://github.com/lunn/linux
>> into orion_fixes_for_v3.4
>
>I just noticed that you said 'for v3.4', not 'for v3.5'. We're really
>late
>in the cycle now, so I would only take serious bug fixes and
>regressions,
>everything else would better go into v3.5. Which of these are critical
>and required for v3.4 (i.e. which ones would you backport if v3.4 was
>already released)?
>
>	Arnd

Yes, my mistake.  I thought what Andrew tested was fixes for v3.4.

The only thing I would push to stable and v3.4 is the mv_cesa fix.  I'll send an amended pull request in a few hours.

Thx,

Jason. 
