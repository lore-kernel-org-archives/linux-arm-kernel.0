From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Feb 2015 16:57:09 +0100
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.20 (round 3)
In-Reply-To: <54D0EE90.1040708@lakedaemon.net>
References: <54D0ECF2.9050104@free-electrons.com>
 <54D0EE90.1040708@lakedaemon.net>
Message-ID: <54D0EFD5.5090500@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 16:51, Jason Cooper wrote:
> On 2/3/15 10:44 AM, Gregory CLEMENT wrote:
>> Hi Olof, Arnd,
>>
>> This is the third incremental pull request for mvebu/dt. I now it
>> comes very late, but as explained in my email series it should not
>> introduce any regression as all the change are made inside the comment
>> blocks, so for the stability it should be safe to take them.
>>
>> My main motivation for having this series merged in 3.20 is to avoid
>> asking each author of the dts(i) patches if he agrees with the dual
>> license during the next cycle. At the end it is not something
>> essential but it will make our life easier.
>>
>> Thanks,
>>
>> Gregory
>>
>> The following changes since commit 6cc082a84e13f3a0078973a08adf22f1404acc3d:
>>
>>    ARM: mvebu: make DTS comments reflect DEBUG_LL changes (2015-01-21 18:36:14 -0600)
> 
> Good incremental pull from the previous tag.
> 
>>
>> are available in the git repository at:
>>
>>    ssh://git.infradead.org/srv/git/linux-mvebu.git tags/mvebu-dt-3.20-3
> 
> oops.  Please resend with the git:// url.  I tend to have two remotes 
> for this sort of thing, 'mvebu' -> ssh://, and 'mvebu-pub' -> git://
> 
> Then, I just make sure I see 'mvebu-pub' in the middle of the 
> request-pull command.

I have noticed you have this configuration, and it was with this mistake that I realized
how useful is it.

Thanks,

Gregory

> 
> hth,
> 
> Jason.
> 
>>
>> for you to fetch changes up to 3c21b5fa897ae4b594d6b76a4572741fea7824b7:
>>
>>    ARM: mvebu: armada-xp-synology-ds414: Relicense the device tree under GPLv2+/X11 (2015-01-26 19:28:13 -0600)
>>
>> ----------------------------------------------------------------
>> Relicense all Armada dts{i} files under dual license of GPLv2+ and
>> X11. This should make it easier to reuse these files with other
>> operating systems and boot loaders.
>>
>> ----------------------------------------------------------------
>> Gregory CLEMENT (27):
>>        ARM: mvebu: armada-370-db: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370-mirabox: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370-netgear-rn102: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370-netgear-rn104: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370-rd: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370-synology-ds213j: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-370-xp: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-375-db: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-375: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-380: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-388-db: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-385: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-388-rd: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-38x: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-axpwifiap: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-db: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-gp: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-lenovo-ix4-300d: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-matrix: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-mv78230: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-mv78260: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-mv78460: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-netgear-rn2120: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-openblocks-ax3-4: Relicense the device tree under GPLv2+/X11
>>        ARM: mvebu: armada-xp-synology-ds414: Relicense the device tree under GPLv2+/X11
>>
>>   arch/arm/boot/dts/armada-370-db.dts              | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-370-mirabox.dts         | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 41 +++++++++++++++++++++++++++++++++++++----
>>   arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 41 +++++++++++++++++++++++++++++++++++++----
>>   arch/arm/boot/dts/armada-370-rd.dts              | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-370-synology-ds213j.dts | 41 +++++++++++++++++++++++++++++++++++++----
>>   arch/arm/boot/dts/armada-370-xp.dtsi             | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-370.dtsi                | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-375-db.dts              | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-375.dtsi                | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-380.dtsi                | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-385.dtsi                | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-388-db.dts              | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-388-rd.dts              | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-38x.dtsi                | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-db.dts               | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-gp.dts               | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 41 +++++++++++++++++++++++++++++++++++++----
>>   arch/arm/boot/dts/armada-xp-matrix.dts           | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 41 +++++++++++++++++++++++++++++++++++++----
>>   arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 40 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 41 +++++++++++++++++++++++++++++++++++++----
>>   arch/arm/boot/dts/armada-xp.dtsi                 | 40 +++++++++++++++++++++++++++++++++++++---
>>   27 files changed, 999 insertions(+), 87 deletions(-)
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
