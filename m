From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 17 Dec 2012 16:23:47 +0100
Subject: ARM realview breakages w/ 3.7 under qemu
In-Reply-To: <20121217151348.GC22633@mudshark.cambridge.arm.com>
References: <50CA0FC1.5090009@openwrt.org>
 <20121213174817.GB12946@mudshark.cambridge.arm.com>
 <20121214094012.GG14363@n2100.arm.linux.org.uk>
 <50CB0150.1000901@openwrt.org>
 <20121217134246.GE11558@mudshark.cambridge.arm.com>
 <50CF26D2.1040008@openwrt.org>
 <20121217151348.GC22633@mudshark.cambridge.arm.com>
Message-ID: <50CF3903.2020206@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/17/12 16:13, Will Deacon a ?crit :
> [snip]
>> Ok, there must be something specific to qemu, can you also try with it?
> Works too, but I had to add mem=128M to the command line (I guess the ATAGs
> are wrong).

Ok, works for me too. Thank you.
>
>>> For EB, can you try the following diff please?
>> Works for me, thank you! I realized that I had this patch for 3.3
>> already, but not in 3.7. This means that Realview EB has been broken
>> since 3.3-rc and specifically commit 34ae6c96 (ARM: 7298/1: realview:
>> fix mapping of MPCore private memory region).
> Cool, can I re-post with your tested-by please?
Sure:

Tested-by: Florian Fainelli <florian@openwrt.org>

Thank you
--
Florian
