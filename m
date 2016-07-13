From: sr@denx.de (Stefan Roese)
Date: Wed, 13 Jul 2016 11:38:09 +0200
Subject: [PATCH] arm: mvebu: Add SPI1 pinctrl defines for Armada XP
In-Reply-To: <20160229114230.52ca0837@free-electrons.com>
References: <1456739914-12096-1-git-send-email-sr@denx.de>
 <20160229114230.52ca0837@free-electrons.com>
Message-ID: <57860C01.2080109@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 29.02.2016 11:42, Thomas Petazzoni wrote:
> On Mon, 29 Feb 2016 10:58:34 +0100, Stefan Roese wrote:
>> This patch defines and uses common Armada XP pinctrl settings in
>> armada-xp.dtsi for the SPI1 interface (MPP13,14,16,17).
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>   arch/arm/boot/dts/armada-xp.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I'm currently rebasing my SPI dts patches and noticed that this
patch is not in mailine yet. Should I perhaps send it again with
the SPI dts move patches?

Thanks,
Stefan
