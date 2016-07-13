From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Jul 2016 11:43:32 +0200
Subject: [PATCH] arm: mvebu: Add SPI1 pinctrl defines for Armada XP
In-Reply-To: <57860C01.2080109@denx.de> (Stefan Roese's message of "Wed, 13
 Jul 2016 11:38:09 +0200")
References: <1456739914-12096-1-git-send-email-sr@denx.de>
 <20160229114230.52ca0837@free-electrons.com>
 <57860C01.2080109@denx.de>
Message-ID: <87bn21swjf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,
 
 On mer., juil. 13 2016, Stefan Roese <sr@denx.de> wrote:

> Hi Gregory,
>
> On 29.02.2016 11:42, Thomas Petazzoni wrote:
>> On Mon, 29 Feb 2016 10:58:34 +0100, Stefan Roese wrote:
>>> This patch defines and uses common Armada XP pinctrl settings in
>>> armada-xp.dtsi for the SPI1 interface (MPP13,14,16,17).
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> ---
>>>   arch/arm/boot/dts/armada-xp.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> I'm currently rebasing my SPI dts patches and noticed that this
> patch is not in mailine yet. Should I perhaps send it again with
> the SPI dts move patches?

Yes sure, there was no reason to not having merging it at this time, I
think I've just missed it.

Gregory

>
> Thanks,
> Stefan

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
