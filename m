From: nobin.mathew@gmail.com (Nobin Mathew)
Date: Wed, 2 Jun 2010 20:04:28 +0530
Subject: make ARM=arm menuconfig problem in mainline
In-Reply-To: <AANLkTikC61Y9g-WbqwgGDghDSy2XtgraFSRoZYkHRGTG@mail.gmail.com>
References: <AANLkTikC61Y9g-WbqwgGDghDSy2XtgraFSRoZYkHRGTG@mail.gmail.com>
Message-ID: <AANLkTilEYHVHJrj_KgF48OYCSEUcsKLi57Q_Y73d9va-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adding linux-arm-kernel at lists.infradead.org

Hi,

The following entry creates problem in ARM System type menu. I am
using a Fedora 12 system.

Length of bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440,
S3C2442, S3C2443, S3C2450" is the problem. How can I fix it.

config ARCH_S3C2410
? ? ? ?bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440,
S3C2442, S3C2443, S3C2450"
? ? ? ?select GENERIC_GPIO
? ? ? ?select ARCH_HAS_CPUFREQ
? ? ? ?select HAVE_CLK
? ? ? ?select ARCH_USES_GETTIMEOFFSET
? ? ? ?help
? ? ? ? ?Samsung S3C2410X CPU based systems, such as the Simtec Electronics
? ? ? ? ?BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
? ? ? ? ?the Samsung SMDK2410 development board (and derivatives).

? ? ? ? ?Note, the S3C2416 and the S3C2450 are so close that they even share
? ? ? ? ?the same SoC ID code. This means that there is no seperate machine
? ? ? ? ?directory (no arch/arm/mach-s3c2450) as the S3C2416 was first.

Thanks
Nobin
