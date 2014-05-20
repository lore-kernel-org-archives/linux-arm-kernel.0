From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 20 May 2014 14:45:43 +0400
Subject: [PATCH v2 1/3] ARM: shmobile: r8a7791: add internal PCI bridge
 nodes
In-Reply-To: <5095898.2pUCzGkcW7@wuerfel>
References: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
 <201405200152.06575.sergei.shtylyov@cogentembedded.com>
 <5095898.2pUCzGkcW7@wuerfel>
Message-ID: <537B3257.5000105@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-05-2014 12:04, Arnd Bergmann wrote:

>> +               interrupt-map-mask = <0xff00 0 0 0x7>;
>> +               interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>> +                                0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>> +                                0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;

> Are there only internal devices on this PCI host?

    Yes, and all populated device slots are listed.

> 	Arnd

WBR, Sergei
