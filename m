From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 28 Feb 2014 10:35:45 -0500
Subject: [PATCH v2 5/7] ARM: of: introduce common routine for DMA
 configuration
In-Reply-To: <11548178.4dQyMzBAP8@wuerfel>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <9618080.kpE3Kl6X8p@wuerfel> <5310A5F1.9070901@ti.com>
 <11548178.4dQyMzBAP8@wuerfel>
Message-ID: <5310ACD1.2080000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 10:31 AM, Arnd Bergmann wrote:
> On Friday 28 February 2014 10:06:25 Santosh Shilimkar wrote:
>> I made that LPAE specific assuming the 32 machines anyway are
>> happy with default as they are today. We can keep CONFIG_ARM
>> and handle the special case in machine platform notifier.
> 
> I think all other machines that support LPAE can also run with
> LPAE disabled and still use coherent DMA, they may just not
> support all the available RAM.
> 
Fair enough.

Regards,
Santosh
