From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 17:03:27 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205151106.46761.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205151106.46761.arnd@arndb.de>
Message-ID: <4FB27E4F.7010908@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 12:06, Arnd Bergmann wrote:
> On Tuesday 15 May 2012, Thomas Petazzoni wrote:
>> You'll find in this patch set the initial support for a new family of
>> ARMv7-compatible Marvell SoCs, that we have choosen to support in the
>> arch/arm/mach-armada/ directory.
>>
>> At the moment, both the Armada 370 and the Armada XP SoCs are
>> supported in this directory, and we are able to build a single kernel
>> image that boots on both SoCs. Both SoCs use the PJ4B processor, a
>> Marvell-developed ARM core that implements the ARMv7 instruction
>> set. We are currently using Marvell evaluation boards for both of
>> those SoCs, and the support for those boards is added in this patch
>> set.
>>
>> This preliminary support only includes the necessary code for timer
>> and IRQ support, the serial controller is a standard 16550-compatible
>> one. The diffstat looks like:
>
> Hi Thomas,
>
> The code looks reasonable overall, but I fear your timing is unfortunate
> and we can't expect to complete the review before the merge window opens.
> Things would have been much easier if you had posted preliminary versions
> a few weeks earlier, but my feeling is that this should be treated
> as v3.6 material.

I'm happy for this to go in once v3.5 is out as long as the issues
with the device-tree binding is sorted out and the few issues that
have cropped up in testing are fixed.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
