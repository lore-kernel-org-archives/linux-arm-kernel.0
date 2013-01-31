From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Jan 2013 09:50:15 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <2206499.VqjeY6AxuS@bender>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <2206499.VqjeY6AxuS@bender>
Message-ID: <510A3047.5070503@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 08:30 PM, Florian Fainelli wrote:
> On Wednesday 30 January 2013 18:26:14 Gregory CLEMENT wrote:
>> This is the new Armada XP evaluation board from Marvell. It comes with
>> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
>> Gigabit links.
>>
>> Support for USB (Host and device), SDIO, PCIe will be added as drivers
>> when they become available for Armada XP in mainline.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Tested-by: Florian Fainelli <florian@openwrt.org>
> 
> The PHY mapping you have is the right one, besides the minor naming in model 
> and header comment, this is good, thanks a lot!
> 
Thanks!
So I am waiting for the official Tested-by from Simon, and I will send a V2
patch with the name fixed and with your tested-by.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
