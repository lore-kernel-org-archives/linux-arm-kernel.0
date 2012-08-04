From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 4 Aug 2012 12:13:13 +0800
Subject: [PATCH 6/7] arm: mmp&dove: modify tauros2_init call
In-Reply-To: <501786AB.5010608@free-electrons.com>
References: <20120731070153.GA13777@lunn.ch>
 <CADApbehptEE++NoxBmTuPmbWY7q9Je_vXPxMv3Sq86_f_SpBCg@mail.gmail.com>
 <501786AB.5010608@free-electrons.com>
Message-ID: <CAN1soZxrxgarm2yF1WMuapvNN-1Vh8PXW7_RVpGVByKhX96QEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 3:18 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On 07/31/2012 09:09 AM, Chao Xie wrote:
>> On Tue, Jul 31, 2012 at 3:01 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>> Hi Chao
>>>
>>> When making changes to Dove, or any other Orion system, please could
>>> you CC: the orion maintainers:
>>>
>>> ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
>>> M:      Jason Cooper <jason@lakedaemon.net>
>>> M:      Andrew Lunn <andrew@lunn.ch>
>>> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>> S:      Maintained
>>> F:      arch/arm/mach-dove/
>>> F:      arch/arm/mach-kirkwood/
>>> F:      arch/arm/mach-mv78xx0/
>>> F:      arch/arm/mach-orion5x/
>>> F:      arch/arm/plat-orion/
>>>
>>> Does this also affect Armada 370 and Armada XP SOC? I've no idea what
>>> cache it uses.
>>>
>>> Thanks
>>>         Andrew
>> It will impact Armada 370. The patch will make the user has choice to
>> enable extra features of tauros2
>
> As far as I know it wouldn't impact the Armada370 as it use an other L2
> called Aurora. We are currently working on it to submit it really soon.
> The ArmadaXP also use the Aurora L2 cache controller.
>
OK. I'll merge these patches.

Regards
Haojian
