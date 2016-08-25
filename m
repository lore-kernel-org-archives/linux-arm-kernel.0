From: sza@esh.hu (=?utf-8?Q?Szemz=C5=91_Andr=C3=A1s?=)
Date: Thu, 25 Aug 2016 12:15:19 +0200
Subject: [PATCH v2 0/8] ARM: V7M: Support caches
In-Reply-To: <57B5CCDE.10504@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
 <20160818145300.GA1041@n2100.armlinux.org.uk> <57B5CCDE.10504@arm.com>
Message-ID: <DE49772B-3F4D-46A4-AC46-320A0ECCA1C2@esh.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On 18 Aug 2016, at 16:57, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> 
> Is it acceptable if patches hang on a list for awhile, so people (I'm
> looking at Alex and  Szemz?) can test them?
> 

This is my first email to the list, so sorry If I make mistakes with my report,
I still need to learn?

I have tested these patches on my custom board with ATMEL SAME70 armv7m SoC.

With default memory mapping configured MPU booting and rebooting works fine, I don?t see any issues. 
The system shows significant overall speedup as expected.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.8.0-rc2 (root at debian) (gcc version 4.8.3 20140320 (prerelease) 
(Sourcery CodeBench Lite 2014.05-29) ) #23 PREEMPT Tue Aug 23 22:5 0:19 CEST 2016
[    0.000000] CPU: ARMv7-M [410fc271] revision 1 (ARMv7M), cr=00000000
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt:Machine model: SAME70-sampione board

So you can add my Tested-by.

Thanks for the patches!

Regards,
Andras Szemzo
