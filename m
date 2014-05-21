From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 May 2014 15:53:22 +0200
Subject: [PATCH v6 10/17] ARM: mvebu: add USB3 support for Armada 38x
In-Reply-To: <1400497768.2007.10.camel@x220>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>	
 <1400149062-32661-11-git-send-email-gregory.clement@free-electrons.com>	
 <20140516190729.GN27822@titan.lakedaemon.net> <1400497768.2007.10.camel@x220>
Message-ID: <537CAFD2.3080807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/2014 13:09, Paul Bolle wrote:
> On Fri, 2014-05-16 at 15:07 -0400, Jason Cooper wrote:
>> On Thu, May 15, 2014 at 12:17:35PM +0200, Gregory CLEMENT wrote:
>>> This patch adds the selection of the config symbol needed to build the
>>> USB3 support for Armada 38x into mvebu_v7_defconfig.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> ---
>>>  arch/arm/mach-mvebu/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Patches 10 and 11 applied to mvebu/soc
> 
> These two just hit linux-next (in next-20140519). They're pointless, as
> config USB_ARCH_HAS_XHCI was dropped in commit b797b76fb464 ("usb: host:
> remove USB_ARCH_HAS_?HCI").

Right! We didn't notice it.

Jason you can simply remove them from mvebu/soc when you will submit the pull request


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
