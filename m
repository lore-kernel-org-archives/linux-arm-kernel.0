From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 May 2017 10:44:05 -0700
Subject: [GIT PULL] bcm2835 DT fixes for 4.12
In-Reply-To: <1791886363.81865.1496251246175@email.1und1.de>
References: <20170516221931.31292-1-eric@anholt.net>
 <d16bf00b-d058-08d1-ed6a-2f369d1fd611@gmail.com>
 <1791886363.81865.1496251246175@email.1und1.de>
Message-ID: <98834BF8-FEC0-4DCB-B2C1-C2B1838AF5B6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 31, 2017 10:20:46 AM PDT, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>Hi Florian,
>
>> Florian Fainelli <f.fainelli@gmail.com> hat am 19. Mai 2017 um 20:17
>geschrieben:
>> 
>> 
>> On 05/16/2017 03:19 PM, Eric Anholt wrote:
>> > Hi Florian,
>> > 
>> > The following changes since commit
>2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>> > 
>> >   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>> > 
>> > are available in the git repository at:
>> > 
>> >   git://github.com/anholt/linux tags/bcm2835-dt-fixes-2017-05-16
>> > 
>> > for you to fetch changes up to
>b0804ed0cadd7e38d94d2f15cdcc0d9695818856:
>> > 
>> >   ARM: dts: bcm283x: Reserve first page for firmware (2017-05-15
>15:05:29 -0700)
>> > 
>> > ----------------------------------------------------------------
>> > This pull request brings in a fix for booting on SMP Raspberry Pis,
>> > particularly with maxcpus=1
>> > 
>> > ----------------------------------------------------------------
>> 
>> Merged, thanks Eric
>
>when it's planned to send this fix to Olof?

It's been sent and merged already but I realized lakml was not copied:

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=fixes
Hi,
-- 
Florian
